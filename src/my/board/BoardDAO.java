package my.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	// ConnectionPoolBean 방식 미사용

	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";

	public BoardDAO() {
	}

	// 연결메소드 : 로그인까지
	public void connect() {
		try {
			Class.forName(driverClassName);
			con = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			// System.out.println("연결 오류");
			e.printStackTrace();// 오류처리 안한것처럼 출력
		}
	}

	// 자원반납메소드
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 이후의 작업들은 메소드 단위로 처리

	// boolean result = bdao.insertBoard(bdto);
	public boolean insertBoard(BoardDTO bdto) throws SQLException {
		String sql = "insert into board values(board_seq.nextval,"
				+ "?,?,?,?,sysdate,0,0)";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, bdto.getWriter());
			ps.setString(2, bdto.getTitle());
			ps.setString(3, bdto.getContent());
			ps.setString(4, bdto.getPw());
			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// int no = bdao.findNumber();
	public int findNumber() throws SQLException {
		String sql = "select max(no) from board";
		try {
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();// 데이터가 반드시 1개는 있다
			rs.next();// 무조건 있으므로 이동하라!
			int max = rs.getInt(1);
			return max;
		} finally {
			close();
		}
	}

	public ArrayList<BoardDTO> searchBoard(String search, String searchString,
			int start, int end) throws SQLException {
		String sql = "select * from (select rownum rn, A.* from + "
				+ "(select * from board where " + search
				+ " like ?order by no desc)A) where rn between ? and ?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%" + searchString + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	// list = bdao.searchBoard(search, searchString);//검색
	public ArrayList<BoardDTO> searchBoard(String search, String searchString)
			throws SQLException {
		String sql = "select * from board where " + search
				+ " like ? order by no desc";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%" + searchString + "%");
			rs = ps.executeQuery();
			// ArrayList<BoardDTO>로 변경
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	public ArrayList<BoardDTO> listBoard(int start, int end)
			throws SQLException {
		String sql = "select * from (select rownum rn, "
				+ "A.* from (select * from board order "
				+ "by no desc)A) where rn between ? and ?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	// list = bdao.listBoard();//목록
	public ArrayList<BoardDTO> listBoard() throws SQLException {
		String sql = "select * from board order by no desc";
		try {
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	// ArrayList<BoardDTO> list = makeList(rs);
	public ArrayList<BoardDTO> makeList(ResultSet rs) throws SQLException {
		// 1. 저장소 생성
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		// 2. rs에서 데이터 이동
		while (rs.next()) {
			// 2-1. 데이터 추출
			int no = rs.getInt("no");
			String writer = rs.getString("writer");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String pw = rs.getString("pw");
			String regdate = rs.getString("regdate");
			int readcount = rs.getInt("readcount");
			int recommand = rs.getInt("recommand");

			// 2-2. 데이터 포장
			BoardDTO bdto = new BoardDTO(no, writer, title, content, pw,
					regdate, readcount, recommand);

			// 2-3. 데이터 등록(list)
			list.add(bdto);
		}

		// 3. list 반환
		return list;
	}

	// BoardDTO bdto = bdao.getBoard(no);
	public BoardDTO getBoard(int no) throws SQLException {
		String sql = "select * from board where no=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();// 데이터 1개 또는 0개
			ArrayList<BoardDTO> list = makeList(rs);
			// list에 데이터가 없을때는 문제가 된다
			if (list == null || list.size() == 0) {
				return null;
			}
			BoardDTO bdto = list.get(0);
			return bdto;
		} finally {
			close();
		}
	}

	// bdao.plusCount(no);
	public void plusCount(int no) throws SQLException {
		String sql = "update board " + "set readcount = readcount+1 "
				+ "where no=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			int result = ps.executeUpdate();
		} finally {
			close();
		}
	}

	// boolean result = bdao.checkPw(no, pw);
	public boolean checkPw(int no, String pw) throws SQLException {
		String sql = "select no from board where no=? and pw=?";
		// select pw from board where no=?
		// select no from board where no=? and pw=?
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			return rs.next();
		} finally {
			close();
		}
	}

	// boolean result = bdao.deleteBoard(no);
	public boolean deleteBoard(int no) throws SQLException {
		String sql = "delete board where no=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// boolean result = bdao.editBoard(bdto);
	public boolean editBoard(BoardDTO bdto) throws SQLException {
		String sql = "update board set title=?, content=? " + "where no=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, bdto.getTitle());
			ps.setString(2, bdto.getContent());
			ps.setInt(3, bdto.getNo());
			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// int count = bdao.getBoardCount();
	public int getBoardCount() throws SQLException {
		String sql = "select count(*) from board";
		try {
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();// 데이터 무조건 1개
			rs.next();
			int count = rs.getInt(1);
			return count;
		} finally {
			close();
		}
	}
}
