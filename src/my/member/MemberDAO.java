package my.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO {
	// 멤버 변수 : DB연결과 관련된 객체 또는 정보들을 보관
	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";

	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	// 생성자 : 기본적으로 기본생성자는 만들어 두도록 한다.
	public MemberDAO() {
	}

	// 멤버 메소드

	// 연결 메소드 : 드라이버 검색->로그인 까지 수행
	public void connect() {
		try {
			Class.forName(driverClassName);// ClassNotFoundEx
			con = DriverManager.getConnection(url, user, pass);
			// SQLEx
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
				con.close();
		} catch (SQLException e) {
			System.out.println("DB 연결 종료 과정에서 오류 발생");
		}
	}

	public boolean deleteMember(int no) throws SQLException {
		String sql = "delete member where no=?";

		try {
			connect();
			// 명령문을 집어넣고
			ps = con.prepareStatement(sql);
			// 명령문에 ? 가 있으니 그자리에 writer로 채워 넣어라
			ps.setInt(1, no);
			int result = ps.executeUpdate();// Update는 int형태의 반환형을 가진다.
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// boolean check = mbdao.checkMember(id);
	// boolean checkMember(String)
	public boolean checkMember(String id) throws SQLException {
		String sql = "select no from member where id = ?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {// 데이터 있는 경우 : 거절
				return false;
			} else {// 데이터가 없는 경우 : 가입
				return true;
			}
		} finally {
			close();
		}
	}

	public String loginMember(String id, String pw) throws SQLException {
		String sql = "select no from member where id = ?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (!rs.next()) {// 데이터 업는 경우 : 안됨
				return "해당 id는 없는 id입니다.";
			} else {
				sql = "select no from member where id = ? and pw =?";
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				if (!rs.next()) {// 업는 경우 : 안됨
					return "해당 id에 맞지않는 pw입니다.";
				} else {
					return "로그인에 성공하셨습니다.";
				}
			}
		} finally {
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

	// boolean result = mbdao.insertMember(mbdto);
	// boolean insertMember(MemberDTO)
	public boolean insertMember(MemberDTO mbdto) throws SQLException {
		String sql = "insert into member values("
				+ "member_seq.nextval,?,?,?,?,sysdate,?,?,?,?,?)";
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표 9개
			ps.setString(1, mbdto.getId());
			ps.setString(2, mbdto.getPw());
			ps.setString(3, mbdto.getName());
			ps.setString(4, mbdto.getBirth());
			ps.setString(5, mbdto.getGender());
			ps.setString(6, mbdto.getPost());
			ps.setString(7, mbdto.getAddr1());
			ps.setString(8, mbdto.getAddr2());
			ps.setString(9, mbdto.getPower());

			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}

	// list = mbdao.findMember(search, searchString);
	// ArrayList<MemberDTO> findMember(String,String)
	public ArrayList<MemberDTO> findMember(String search, String searchString)
			throws SQLException {

		String sql = "select * from member where" + search + " = ?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			// 물음표 두개
			ps.setString(1, search);
			ps.setString(2, searchString);
			rs = ps.executeQuery();
			ArrayList<MemberDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	public ArrayList<MemberDTO> listMember() throws SQLException {
		String sql = "select * from member order by no asc";
		try {
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			// rs - > ArrayList(변환)
			ArrayList<MemberDTO> list = makeList(rs);
			return list;
		} finally {
			close();
		}
	}

	// ArrayList<MemberDTO> list = makeList(rs);
	// ArrayList<MemberDTO> makeList(ResultSet);
	public ArrayList<MemberDTO> makeList(ResultSet rs) throws SQLException {
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();

		while (rs.next()) {
			// 1.데이터 추출
			int no = rs.getInt("no");
			String id = rs.getString("id");
			String pw = rs.getString("pw");
			String name = rs.getString("name");
			String birth = rs.getString("birth");
			String joindate = rs.getString("joindate");
			String gender = rs.getString("gender");
			String post = rs.getString("post");
			String addr1 = rs.getString("addr1");
			String addr2 = rs.getString("addr2");
			String power = rs.getString("power");

			// 2.DTO포장
			MemberDTO mbdto = new MemberDTO(no, id, pw, name, birth, joindate,
					gender, post, addr1, addr2, power);
			// 3.ArrayList등록
			// int no = rs.getInt("no");
			list.add(mbdto);
		}
		return list;
	}

	// MemberDTO info = mbdao.getMember(no);
	public MemberDTO getMember(int no) throws SQLException {
		String sql = "";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();// 데이터 개수?? 0 개 또는 1개

			ArrayList<MemberDTO> list = makeList(rs);
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
	public boolean editMember(MemberDTO mbdto) throws SQLException {
		// 1.비밀번호 검사 - 거절
		// [1]query2개로 검사 select pw from member where no=? 후 비밀번호 equals 검사
		// [2]query1개로 검사 select 아무거나 from member where no=? and pw=? 후에 데이터 있나
		// 없나 검사
		// 2.수정 처리
		// [1]
		// [2]update member set post=?, addr1=?, addr2=? where no=? and pw=?

		// 하지만 2번의 한번에 처리하는 방법은 어느부분이 틀렸는지 사용자에게 알려줄 수 없다.

		String sql = "update member set post=?, addr1=?, addr2=? where no=? and pw=?";
		try {
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, mbdto.getPost());
			ps.setString(2, mbdto.getAddr1());
			ps.setString(3, mbdto.getAddr2());
			ps.setInt(4, mbdto.getNo());
			ps.setString(5, mbdto.getPw());

			int result = ps.executeUpdate();
			if (result > 0)
				return true;
			else
				return false;
		} finally {
			close();
		}
	}
}
