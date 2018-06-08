package login1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class UserDAO {

    private static User createUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setId(resultSet.getInt("id"));
        user.setLoginId(resultSet.getString("loginId"));
        user.setPassword(resultSet.getString("password"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setDepartmentId(resultSet.getInt("departmentId"));
        if (resultSet.wasNull()) user.setDepartmentId(null);
        user.setEnabled(resultSet.getBoolean("enabled"));
        user.setUserType(resultSet.getString("userType"));
        user.setDepartmentName(resultSet.getString("departmentName"));
        return user;
    }

    public static List<User> findAll(int currentPage, int pageSize, String ss, String st, String od) throws Exception {
        String sql = "call user_findAll(?, ?, ?, ?, ?)";
        try (Connection connection = DB.getConnection("bbs1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, (currentPage - 1) * pageSize); // firstRecordIndex
            statement.setInt(2, pageSize);                     // pageSize
            statement.setString(3, ss);                        // 조회 방법
            statement.setString(4, st + "%");                  // 검색 문자열
            statement.setString(5, od);                        // 정렬 순서
            try (ResultSet resultSet = statement.executeQuery()) {
                ArrayList<User> list = new ArrayList<User>();
                while (resultSet.next())
                    list.add(createUser(resultSet));
                return list;
            }
        }
    }

    public static int count(String ss, String st) throws Exception {
        String sql = "call user_count(?, ?)";
        try (Connection connection = DB.getConnection("bbs1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, ss);        // 조회 방법
            statement.setString(2, st + "%");  // 검색 문자열
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next())
                    return resultSet.getInt(1);
            }
        }
        return 0;
    }

    public static User findOne(int id) throws Exception {
        String sql = "SELECT u.*, departmentName" +
                     " FROM user u LEFT JOIN department d ON u.departmentId = d.id" +
                     " WHERE u.id = ?";
        try (Connection connection = DB.getConnection("bbs1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) return createUser(resultSet);
            }
            return null;
        }
    }

    public static User findByLoginId(String loginId) throws Exception {
        String sql = "SELECT u.*, departmentName" +
                " FROM user u LEFT JOIN department d ON u.departmentId = d.id" +
                " WHERE u.loginId = ?";
        try (Connection connection = DB.getConnection("bbs1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, loginId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) return createUser(resultSet);
            }
            return null;
        }
    }

    public static void update(User user) throws Exception {
        String sql =
                "UPDATE user SET loginId=?, name=?, email=?, departmentId=?, enabled=?, userType=? " +
                " WHERE id = ?";
        try (Connection connection = DB.getConnection("bbs1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getLoginId());
            statement.setString(2, user.getName());
            statement.setString(3, user.getEmail());
            Integer departmentId = user.getDepartmentId();
            if (departmentId == null || departmentId == 0) statement.setNull(4, java.sql.Types.INTEGER);
            else statement.setInt(4, departmentId);
            statement.setBoolean(5, user.isEnabled());
            statement.setString(6, user.getUserType());
            statement.setInt(7, user.getId());
            statement.executeUpdate();
        }
    }
}

