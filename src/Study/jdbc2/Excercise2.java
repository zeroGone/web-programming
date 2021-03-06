package Study.jdbc2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class Excercise2 {
	public static List<Student> find(int currentPage,int pageSize,String department,String name) throws Exception{
		String sql = "SELECT s.*, d.departmentName " +
				"FROM student s LEFT JOIN department d ON s.departmentId = d.id "+
				"where departmentName like ? and name like ? "+//검색할 이름의 조건을 걺
				"LIMIT ?, ?";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setString(1,department+"%");
			statement.setString(2,name+"%");
			statement.setInt(3, (currentPage-1)*pageSize);//출력할 페이지의 시작점
			statement.setInt(4, pageSize);//페이지사이즈만큼 학생정보를 받아옴
			try(ResultSet resultSet = statement.executeQuery()){
				ArrayList<Student> list = new ArrayList<Student>();
				while (resultSet.next()) {
					Student student = new Student();
					student.setId(resultSet.getInt("id"));
					student.setStudentNumber(resultSet.getString("studentNumber"));
					student.setName(resultSet.getString("name"));
					student.setDepartmentId(resultSet.getInt("departmentId"));
					student.setYear(resultSet.getInt("year"));
					student.setDepartmentName(resultSet.getString("departmentName"));
					list.add(student);
				}
				return list;
			}
		}
	}	
	public static int count(String department,String name) throws Exception {
        String sql = "SELECT COUNT(*) FROM student s "
        		+ "left join department d on s.departmentId=d.id "
        		+ "WHERE departmentName LIKE ? and name LIKE ?";//검색한 이름에 맞는 학생 수를 셈
        try (Connection connection = DB.getConnection("student1");
             PreparedStatement statement = connection.prepareStatement(sql)) {
        	statement.setString(1,department+"%");
            statement.setString(2, name + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next())
                    return resultSet.getInt(1);
            }
        }
        return 0;
    }
}
