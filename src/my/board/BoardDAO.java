package my.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import my.db.ConnectionPoolBean;

public class BoardDAO {

	// PC방 정보만 알고 있으면 된다.
	private ConnectionPoolBean pool;

	// 설정용 setter 메소드
	public void setPool(ConnectionPoolBean pool) {
		this.pool = pool;
	}

	private Connection con;

	private PreparedStatement ps;
	private ResultSet rs;

	// 생성자 : 기본적으로 기본생성자는 만들어 두도록 한다.
	public BoardDAO() {
	}

	// 멤버 메소드

	// 연결 메소드 : 드라이버 검색->로그인 까지 수행
	public void connect() {
		try {
			con = pool.getConnection();
		} catch (Exception e) {
			System.out.println("DB 연결 과정에서 오류 발생");
		}
	}

	// 종료 메소드 : 사용한 자원을 모두 폐기처리
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				pool.returnConnection(con);// 연결 반납
		} catch (SQLException e) {
			System.out.println("DB 연결 종료 과정에서 오류 발생");
		}
	}

	
	public boolean insertBoard(BoardDTO bddto) throws SQLException {
		String sql = "insert into board values("
				+ "board_seq.nextval,?,?,?,?,sysdate,?,?)";
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표 9개
			ps.setString(1, bddto.getWriter());
			ps.setString(2, bddto.getTitle());
			ps.setString(3, bddto.getContent());
			ps.setString(4, bddto.getPw());
			ps.setInt(5, bddto.getReadcount());
			ps.setInt(6, bddto.getRecommand());

			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	public ArrayList<BoardDTO> listBoard() throws SQLException {
		String sql = "select * from board order by no asc";
		try {
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			// rs - > ArrayList(변환)
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	public ArrayList<BoardDTO> makeList(ResultSet rs) throws SQLException {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		while (rs.next()) {
			// 1.데이터 추출
			int no = rs.getInt("no");
			String writer = rs.getString("writer");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String pw = rs.getString("pw");
			String regdate = rs.getString("regdate");
			int readcount = rs.getInt("readcount");
			int recommand = rs.getInt("recommand");

			// 2.DTO포장
			BoardDTO bddto = new BoardDTO(no, writer, title, content, pw, regdate, readcount, recommand);
			// 3.ArrayList등록
			// int no = rs.getInt("no");
			list.add(bddto);
		}
		return list;
	}

	// MemberDTO info = mbdao.getMember(no);
	public BoardDTO getBoard(int no) throws SQLException {
		String sql = "";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();// 데이터 개수?? 0 개 또는 1개

			ArrayList<BoardDTO> list = makeList(rs);
			if (list == null || list.size() == 0) // 데이터가 없으면
				return null;
			else
				// 데이터가 있으면? 0번방 데이터 반환
				return list.get(0);
			/*
			 * if(rs.next()){ ........ 10 개 적어도 된다. }
			 */
		} finally {
			close();
		}
	}

	// boolean result = mbdao.editMember(mbdto);
	public boolean editBoard(BoardDTO bddto) throws SQLException {
	
		String sql = "update board set title=? content=? where no=? and pw=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, bddto.getTitle());
			ps.setString(2, bddto.getContent());
			ps.setInt(3, bddto.getNo());
			ps.setString(4, bddto.getPw());

			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// 상태값 상수 - return 1,2,3대신에 가독성을 위하여 사용한다.
	public static final int OK = 1;
	public static final int NOK = 2;
	public static final int ERROR = 3;

	public int login(int no, String pw) {
		String sql = "";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if (rs.next()) { // 아이디가 있으면
				return OK; // 로그인 성공
			} else {
				return NOK; // 정보오류
			}

		} catch (SQLException e) {
			return ERROR; // 서버오류
		} finally {

			close();
		}
	}
}
