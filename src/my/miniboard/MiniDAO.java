package my.miniboard;

//DAO : Data Access Object
//택배 기사 아저씨 클래스
//DB연결과 관련된 모든 내용들이 이곳으로 옮겨진다.
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class MiniDAO {
	//멤버 변수 : DB연결과 관련된 객체 또는 정보들을 보관
	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//생성자 : 기본적으로 기본생성자는 만들어 두도록 한다.
	public MiniDAO(){}
	
	//멤버 메소드
	
	//연결 메소드 : 드라이버 검색->로그인 까지 수행
	public void connect(){
		try{
			Class.forName(driverClassName);//ClassNotFoundEx
			con = DriverManager.getConnection(url, user, pass);
			//SQLEx
		}catch(Exception e){
			System.out.println("DB 연결 과정에서 오류 발생");
		}
	}
	
	//종료 메소드 : 사용한 자원을 모두 폐기처리
	public void close(){
		try{
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		}catch(SQLException e){
			System.out.println("DB 연결 종료 과정에서 오류 발생");
		}
	}
	
	//insert 만들어서 등록 처리
	//int result = dao.insert(writer, content);
	//int insert(String, String)
	public int insert(String writer, String content) 
													throws SQLException{
		String sql = "insert into miniboard values("
							+ "miniboard_seq.nextval,?,?,sysdate)";
		try{
			connect();//con까지 생성
			ps = con.prepareStatement(sql);
			//물음표 2개
			ps.setString(1, writer);
			ps.setString(2, content);
			
			//실행 후 결과 반환
			int result = ps.executeUpdate();
			return result;
		}finally{
			close();
		}
	}
	
	//list 만들어서 목록 처리
	//ArrayList<MiniDTO> list = dao.list(); 
	//ArrayList<MiniDTO> list()
	//자동 import 단축키 : 컨트롤+쉬프트+O
	public ArrayList<MiniDTO> list() throws SQLException{
		String sql = "select * from miniboard order by no desc";
		try{
			connect();//con까지 생성
			ps = con.prepareStatement(sql);
			//물음표 없음
			rs = ps.executeQuery();//select용 실행 명령
			
			ArrayList<MiniDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//delete 만들어서 삭제 처리
	//boolean result = dao.delete(writer);
	//boolean delete(String)
	public boolean delete(String writer) throws SQLException{
		String sql = "delete miniboard where writer = ?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, writer);
			int result = ps.executeUpdate();
			if(result>0)
				return true;
			else
				return false;
		}finally{
			close();
		}
	}
	
	
	//find 만들어서 검색 처리
	//ArrayList<MiniDTO> list = dao.find(search);
	//ArrayList<MiniDTO> find(String);
	public ArrayList<MiniDTO> find(String search) 
											throws SQLException{
		String sql = "select * from miniboard "
				+ "where writer like ? or content like ? "
				+ "order by no desc";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, "%"+search+"%");
			rs = ps.executeQuery();
			
			//rs -> list로 변경하는 메소드 호출
			ArrayList<MiniDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//makeList 만들어서 ResultSet->ArrayList 변경 처리
	//ArrayList<MiniDTO> list = makeList(rs);
	//ArrayList<MiniDTO> makeList(ResultSet)
	public ArrayList<MiniDTO> makeList(ResultSet rs)
													throws SQLException{
		//데이터는 현재 rs에 있다
		//돌려줄 데이터 형태가 ArrayList<MiniDTO>이므로
		//변환 작업이 필요하다.(ResultSet -> ArrayList<MiniDTO>)
		
		//1. 옮겨질 ArrayList 생성
		ArrayList<MiniDTO> list = new ArrayList<MiniDTO>();
		
		//2. rs의 데이터 전체를 list로 이동
		while(rs.next()){
			//1.rs에서 데이터 추출(4개)
			int no = rs.getInt("no");
			String writer = rs.getString("writer");
			String content = rs.getString("content");
			String joindate = rs.getString("joindate");
			//2.포장하고(MiniDTO)
			MiniDTO dto = 
					new MiniDTO(no, writer, content, joindate);
			//3.추가하고
			list.add(dto);
		}
		//3. 완성된 list 반환
		return list;
	}
	
	//??? 만들어서 ?? 처리
	//...
}









