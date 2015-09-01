package my.miniboard;

//DAO : Data Access Object
//�ù� ��� ������ Ŭ����
//DB����� ���õ� ��� ������� �̰����� �Ű�����.
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class MiniDAO {
	//��� ���� : DB����� ���õ� ��ü �Ǵ� �������� ����
	private String driverClassName = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "jsp1";
	private String pass = "jsp1";
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//������ : �⺻������ �⺻�����ڴ� ����� �ε��� �Ѵ�.
	public MiniDAO(){}
	
	//��� �޼ҵ�
	
	//���� �޼ҵ� : ����̹� �˻�->�α��� ���� ����
	public void connect(){
		try{
			Class.forName(driverClassName);//ClassNotFoundEx
			con = DriverManager.getConnection(url, user, pass);
			//SQLEx
		}catch(Exception e){
			System.out.println("DB ���� �������� ���� �߻�");
		}
	}
	
	//���� �޼ҵ� : ����� �ڿ��� ��� ���ó��
	public void close(){
		try{
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		}catch(SQLException e){
			System.out.println("DB ���� ���� �������� ���� �߻�");
		}
	}
	
	//insert ���� ��� ó��
	//int result = dao.insert(writer, content);
	//int insert(String, String)
	public int insert(String writer, String content) 
													throws SQLException{
		String sql = "insert into miniboard values("
							+ "miniboard_seq.nextval,?,?,sysdate)";
		try{
			connect();//con���� ����
			ps = con.prepareStatement(sql);
			//����ǥ 2��
			ps.setString(1, writer);
			ps.setString(2, content);
			
			//���� �� ��� ��ȯ
			int result = ps.executeUpdate();
			return result;
		}finally{
			close();
		}
	}
	
	//list ���� ��� ó��
	//ArrayList<MiniDTO> list = dao.list(); 
	//ArrayList<MiniDTO> list()
	//�ڵ� import ����Ű : ��Ʈ��+����Ʈ+O
	public ArrayList<MiniDTO> list() throws SQLException{
		String sql = "select * from miniboard order by no desc";
		try{
			connect();//con���� ����
			ps = con.prepareStatement(sql);
			//����ǥ ����
			rs = ps.executeQuery();//select�� ���� ���
			
			ArrayList<MiniDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//delete ���� ���� ó��
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
	
	
	//find ���� �˻� ó��
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
			
			//rs -> list�� �����ϴ� �޼ҵ� ȣ��
			ArrayList<MiniDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//makeList ���� ResultSet->ArrayList ���� ó��
	//ArrayList<MiniDTO> list = makeList(rs);
	//ArrayList<MiniDTO> makeList(ResultSet)
	public ArrayList<MiniDTO> makeList(ResultSet rs)
													throws SQLException{
		//�����ʹ� ���� rs�� �ִ�
		//������ ������ ���°� ArrayList<MiniDTO>�̹Ƿ�
		//��ȯ �۾��� �ʿ��ϴ�.(ResultSet -> ArrayList<MiniDTO>)
		
		//1. �Ű��� ArrayList ����
		ArrayList<MiniDTO> list = new ArrayList<MiniDTO>();
		
		//2. rs�� ������ ��ü�� list�� �̵�
		while(rs.next()){
			//1.rs���� ������ ����(4��)
			int no = rs.getInt("no");
			String writer = rs.getString("writer");
			String content = rs.getString("content");
			String joindate = rs.getString("joindate");
			//2.�����ϰ�(MiniDTO)
			MiniDTO dto = 
					new MiniDTO(no, writer, content, joindate);
			//3.�߰��ϰ�
			list.add(dto);
		}
		//3. �ϼ��� list ��ȯ
		return list;
	}
	
	//??? ���� ?? ó��
	//...
}









