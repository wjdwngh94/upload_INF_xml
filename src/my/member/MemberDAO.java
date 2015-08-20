package my.member;

import java.sql.*;
import java.util.*;

import my.member.MemberDTO;

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

	public boolean insertMember(MemberDTO mbdto) throws SQLException {
		// throw를 썼기 때문에 catch가 아닌 finally
		String sql = "insert into member values(member_seq.nextval,?,?,?,?,sysdate,?,?,?,?,?)";
		try {
			connect();
			// setter getter을 만들어 둔것을 활용한다. !!

			ps = con.prepareStatement(sql);
			ps.setString(1, mbdto.getId());
			ps.setString(2, mbdto.getPw());
			ps.setString(3, mbdto.getName());
			ps.setString(4, mbdto.getBirth());
			ps.setString(5, mbdto.getGender());
			ps.setString(6, mbdto.getPost());
			ps.setString(7, mbdto.getAddr1());
			ps.setString(8, mbdto.getAddr2());
			ps.setString(8, mbdto.getPower());

			// 실행후 결과 반환
			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally { // 무조건 폐기하기 위하여
			close();
		}
	}

	public boolean find(String id) throws SQLException {
		String sql = "select * from member where id = ?";// 쿼리문
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표 없음
			ps.setString(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				// 데이터가 있는 경우 : 거절
				return false;
			} else {
				// 데이터가 없는 경우 : 가입
				return true;
			}
		} finally {
			close();
		}
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
