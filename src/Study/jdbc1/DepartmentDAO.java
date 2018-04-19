package Study.jdbc1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Study.jdbc1.DB;

public class DepartmentDAO {

	public static List<Department> findAll() throws Exception {
		String sql = "SELECT * " +
				"FROM department";
		try (Connection connection = DB.getConnection("student1");
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet resultSet = statement.executeQuery()) {
			ArrayList<Department> list = new ArrayList<Department>();
			while (resultSet.next()) {
				Department d = new Department();
				d.setId(resultSet.getInt("id"));
				d.setName(resultSet.getString("departmentName"));
				list.add(d);
			}
			return list;
		}
	}
}
