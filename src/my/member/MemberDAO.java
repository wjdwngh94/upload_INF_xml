package my.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import my.db.ConnectionPoolBean;

public class MemberDAO {
	//PC방 정보만 알고 있으면 된다.
	private ConnectionPoolBean pool;
	//설정용 setter 메소드
	public void setPool(ConnectionPoolBean pool) {
		this.pool = pool;
	}
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//생성자 : 기본적으로 기본생성자는 만들어 두도록 한다.
	public MemberDAO(){}
	
	//멤버 메소드
	
	//연결 메소드 : 드라이버 검색->로그인 까지 수행
	public void connect(){
		try{
			con = pool.getConnection();//Connection 대여
		}catch(Exception e){
			System.out.println("DB 연결 과정에서 오류 발생");
		}
	}
	
	//종료 메소드 : 사용한 자원을 모두 폐기처리
	public void close(){
		try{
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) pool.returnConnection(con);//연결 반납
		}catch(SQLException e){
			System.out.println("DB 연결 종료 과정에서 오류 발생");
		}
	}
	
	//boolean check = mbdao.checkMember(id);
	//boolean checkMember(String)
	public boolean checkMember(String id) throws SQLException{
		String sql ="select no from member where id = ?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()){//데이터 있는 경우 : 거절
				return false;
			}else{//데이터가 없는 경우 : 가입
				return true;
			}
		}finally{
			close();
		}
	}
	
	//boolean result = mbdao.insertMember(mbdto);
	//boolean insertMember(MemberDTO)
	public boolean insertMember(MemberDTO mbdto)
													throws SQLException{
		String sql = "insert into member values("
			+ "member_seq.nextval,?,?,?,?,sysdate,?,?,?,?,?)";
		try{
			connect();
			ps = con.prepareStatement(sql);
			//물음표 9개
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
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//list = mbdao.findMember(search, searchString);
	//ArrayList<MemberDTO> findMember(String, String)
	public ArrayList<MemberDTO> findMember(String search, 
						String searchString) throws SQLException{
		String sql ="select * from member where "
											+ search + " like ?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			//물음표 2개
			ps.setString(1, "%"+searchString+"%");
			rs = ps.executeQuery();
			ArrayList<MemberDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//list = mbdao.listMember();
	//ArrayList<MemberDTO> listMember()
	public ArrayList<MemberDTO> listMember() 	
													throws SQLException{
		String sql ="select * from member order by no asc";
		try{
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			//rs->ArrayList 변환
			ArrayList<MemberDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//ArrayList<MemberDTO> list = makeList(rs);
	//ArrayList<MemberDTO> makeList(ResultSet)
	public ArrayList<MemberDTO> makeList(ResultSet rs)
													throws SQLException{
		ArrayList<MemberDTO> list = 
							new ArrayList<MemberDTO>();
		
		//데이터 모두 옮겨 담고
		while(rs.next()){
			//1.데이터 추출
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
			
			//2.DTO 포장
			MemberDTO mbdto = new MemberDTO(no, id, 
					pw, name, birth, joindate, gender, post, 
					addr1, addr2, power);
			
			//3.ArrayList 등록
			list.add(mbdto);
		}
		
		//반환
		return list;
	}
	
	//boolean result = mbdao.deleteMember(no);
	public boolean deleteMember(int no) throws SQLException{
		String sql = "delete member where no=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//MemberDTO info = mbdao.getMember(no);
	public MemberDTO getMember(int no) throws SQLException{
		String sql = "select * from member where no=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();//데이터 개수? 0개 또는 1개
			
			ArrayList<MemberDTO> list = makeList(rs);
			if(list==null||list.size()==0)//데이터가 없으면
				return null;
			else//데이터가 있으면? 0번방 데이터 반환
				return list.get(0);
		}finally{
			close();
		}
	}
	
	//boolean result = mbdao.editMember(mbdto);
	public boolean editMember(MemberDTO mbdto) 
													throws SQLException{
		//1.비밀번호 검사
		//	1-1. select pw from member where no=? 
		//			수행 후 비밀번호 equals 검사
		//	1-2. select 아무거나 from member where no=? and pw=?
		//			데이터 있나 없나 검사
		//2.수정처리
		//	2-2. update member set post=?, addr1=?, addr2=?
		//			where no=? and pw=?
		String sql = "update member "
				+ "set post=?,addr1=?,addr2=? "
				+ "where no=? and pw=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, mbdto.getPost());
			ps.setString(2, mbdto.getAddr1());
			ps.setString(3, mbdto.getAddr2());
			ps.setInt(4, mbdto.getNo());
			ps.setString(5, mbdto.getPw());
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//상태값 상수
	public static final int OK = 1;
	public static final int NOK = 2;
	public static final int ERROR = 3;
	
	//int result = mbdao.login(id, pw);
	public int login(String id, String pw){
		String sql = "select no from member where id=? and pw=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if(rs.next()){//데이터가 있으면
				return OK;//로그인성공
			}else{
				return NOK;//정보오류
			}
		}catch(SQLException e){
			return ERROR;//서버오류
		}finally{
			close();
		}
	}
}


















