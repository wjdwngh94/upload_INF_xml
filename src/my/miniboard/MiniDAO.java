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

	// find만들어서 검색처리
	public ArrayList<MiniDTO> find(String writer1) throws SQLException {
		String sql = "select * from miniboard where writer like ? or content like ? order by no asc";// 쿼리문
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표 없음
			ps.setString(1, "%"+writer1+"%");// 유사 검색
			ps.setString(2, "%"+writer1+"%");// 유사 검색
			rs = ps.executeQuery();
			//데이터는 현제 rs에 있다
			//list든 find든 rs에 결과가 들어왔다.
			
			
			ArrayList<MiniDTO> find = new ArrayList<MiniDTO>();
			while (rs.next()) {
				int no = rs.getInt("no");
				String writer = rs.getString("writer");
				String content = rs.getString("content");
				String regdate = rs.getString("regdate");
				MiniDTO dto = new MiniDTO(no, writer, content, regdate);
				find.add(dto);
			}
			return find;
		} finally {
			close();
		}
	}

	
	// delete만들어서 삭제처리
	// int result = dao.delete(writer);
	// int delete(String)
	public boolean delete(String writer) throws SQLException {
		String sql = "delete miniboard where writer=?";
		// "delete [table name] where [조건];

		try {
			connect();
			// 명령문을 집어넣고
			ps = con.prepareStatement(sql);

			// 명령문에 ? 가 있으니 그자리에 writer로 채워 넣어라
			ps.setString(1, writer);
			int result = ps.executeUpdate();// Update는 int형태의 반환형을 가진다.
			if (result > 0)
				return true;
			else
				return false;
		} finally {
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
			ps = con.prepareStatement(sql);
			// 물음표 없음
			rs = ps.executeQuery();// select용 실행 명령

			// 회사의 부장이 나에게 목록을 파일로가져다달라고 했기때문에
			// 인쇄물이 아닌 파일로 저장해서 가져간다.

			// 데이터는 현재 rs에 있지만 돌려줄 데이터의 형태가 ArrayList<MiniDTO> 임으로
			// 변환작업이 필요하다(ResultSet-> ArrayList<MiniDTO>)

			// 포장에 사용되는 클래스 DTO
			// 1. 옮겨질 ArrayList 생성
			ArrayList<MiniDTO> list = new ArrayList<MiniDTO>();

			// 2.rs의 데이터 전체를 list로 이동
			// rs는 오직 화살표로 이동
			while (rs.next()) {

				// 1.rs에서 데이터 추출(4개)
				// 각각의 데이터에 이름을 붙인다.
				int no = rs.getInt("no");
				String writer = rs.getString("writer");
				String content = rs.getString("content");
				String regdate = rs.getString("regdate");

				// 2.포장하고
				MiniDTO dto = new MiniDTO(no, writer, content, regdate);

				// 3.추가하고
				list.add(dto);
			}

			return list;
			// 완성된 list반환
		} finally {
			close();
		}
	}
}
