package Study.jdbc1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import lecture1.DB;

public class StudentDAO2 {
	public static List<Student> findAll() throws Exception {
		String sql = "SELECT s.*, d.departmentName " + "FROM student s LEFT JOIN department d ON s.departmentId = d.id";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
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

	public static List<Student> findName(String studentName) throws Exception {
		String sql = "SELECT s.*, d.departmentName " + "FROM student s LEFT JOIN department d ON s.departmentId = d.id "
				+ "WHERE s.name LIKE ?";// 찾고싶은 이름을 위한 where LIKE문 추가한다
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setString(1, studentName + "%");// 찾고싶은 이름에 %을 붙여서 statement의 메소드를 통해 설정해줌
			try (ResultSet resultSet = statement.executeQuery()) {
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
}
