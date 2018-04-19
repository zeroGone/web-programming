/*디비로부터 학생전체정보,이름정보,학과정보를 받아오기 위한 클래스*/
package Study.jdbc1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO3 {
	
	private static Student creatStudent(ResultSet resultSet) throws SQLException {//학생만드는것의 반복성을 줄이기 위한 메소드
		Student student = new Student();
		student.setId(resultSet.getInt("id"));
		student.setStudentNumber(resultSet.getString("studentNumber"));
		student.setName(resultSet.getString("name"));
		student.setDepartmentId(resultSet.getInt("departmentId"));
		student.setYear(resultSet.getInt("year"));
		student.setDepartmentName(resultSet.getString("departmentName"));
		return student;
	}
	
	public static List<Student> findAll() throws Exception {
		String sql = "SELECT s.*, d.departmentName " +
				"FROM student s LEFT JOIN department d ON s.departmentId = d.id";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Student> list = new ArrayList<Student>();
			while (resultSet.next()) {
				list.add(creatStudent(resultSet));
			}
			return list;
		}
	}

	public static List<Student> findName(String studentName) throws Exception{
		String sql = "SELECT s.*, d.departmentName " +
				"FROM student s LEFT JOIN department d ON s.departmentId = d.id " +
				"WHERE s.name LIKE ?";//찾고싶은 이름을 위한 where LIKE문 추가한다 
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setString(1, studentName+"%");//찾고싶은 이름에 %을 붙여서 statement의 메소드를 통해 설정해줌 
			try(ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Student> list = new ArrayList<Student>();
				while (resultSet.next()) {
					list.add(creatStudent(resultSet));
				}
				return list;
			}
		}
	}
	
	public static List<Student> findDepartment(int id) throws Exception{
		String sql = "SELECT s.*, d.departmentName " +
				"FROM student s LEFT JOIN department d ON s.departmentId = d.id " +
				"WHERE s.departmentId = ?";//찾고싶은 학과 아이디를 조회한다
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql)){
			statement.setInt(1, id);//찾고싶은 학과의 아이디를 statement의 메소드를 통해 설정해줌 
			try(ResultSet resultSet = statement.executeQuery()) {
				ArrayList<Student> list = new ArrayList<Student>();
				while (resultSet.next()) {
					list.add(creatStudent(resultSet));
				}
				return list;
			}
		}
	}
	
	
}
