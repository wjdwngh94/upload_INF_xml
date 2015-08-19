package my.member;

import java.sql.*;
import java.util.*;


public class MemberDAO {
	// 멤버 변수 : DB연결과 관련된 객체 또는 정보들을 보관한다.
	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";

	private Connection con; // Connect는 불러야 값이 들어가는 것이므로 초기값은 NULL이다.
	private PreparedStatement ps;
	private ResultSet rs;

	public MemberDAO() {
	}

	public void connect() {
		try {
			Class.forName(driverClassName); // ojdbc6.jar을 찾는 다
			// ClassNotFountEx
			con = DriverManager.getConnection(url, user, pass); // SQLEx
		} catch (Exception e) {
			System.out.println("오류 발생!!");
		}
	}

	// 종료 메소드 : 사용한 자원을 모두 폐기 처리
	public void close() {
		// 사용을 안한건 NULL
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println("DB종료 과정에서 오류 발생");
		}
	}
}
