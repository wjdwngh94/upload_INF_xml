package my.miniboard;

import java.sql.*;
import java.util.ArrayList;

//DAO : DATA ACCESS OBJEC 데이터 접근 객체
//택배 기사 아저씨 클래스
//물건을 실제로 배달해주는 사람

//DB연결과 관련된 모든 내용이 이곳으로 옮겨 진다.

public class MiniDAO {
	// 멤버 변수 : DB연결과 관련된 객체 또는 정보들을 보관한다.
	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";

	private Connection con; // Connect는 불러야 값이 들어가는 것이므로 초기값은 NULL이다.
	private PreparedStatement ps;
	private ResultSet rs;

	// 생성자 : 기본적으로 기본 생성자는 만들어 두도록 한다.
	public MiniDAO() {
	}

	// 멤버 메소드 : 자주사용하는 것들(드라이버 검색, 로그인, 자원 반납...)
	// 연결 메소드 : 드라이버 검색 -> 로그인 까지 수행
	public void connect() {
		// JSP에서는 _jspService로 번역되기 때문에 그안에
		// try catch에 걸리게 되어 있다.
		// 하지만 JAVA 파일은 내부적으로 처리된 것이 없기 때문에
		// 예외 처리를 해줘야 한다.

		// SQLException : 입력 정보가 잘못되었을 때
		try {
			Class.forName(driverClassName); // ClassNotFountEx
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

	// insert만들어서 처리
	// int result = dao.insert(writer,content);
	// int insert(String, String)
	public int inset(String writer, String content) throws SQLException {
		// throw를 썼기 때문에 catch가 아닌 finally
		String sql = "insert into miniboard values(miniboard_seq.nextval,?,?,sysdate)";
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표가 2개이다.
			ps.setString(1, writer);
			ps.setString(2, content);

			// 실행후 결과 반환
			int result = ps.executeUpdate();
			return result;
		} finally { // 무조건 폐기하기 위하여
			close();
		}
	}

	// list만들어서 목록처리
	// ArrayList<MiniDTO> list = dao.list();
	// ArrayList<MiniDTO> list()
	public ArrayList<MiniDTO> list() throws SQLException {
		String sql = "select * from miniboard order by no desc";
		try {
			connect();
		} finally {
			close();
		}
	}
}
