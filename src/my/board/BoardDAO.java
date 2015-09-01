package my.board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
public class BoardDAO {
	//ConnectionPoolBean ��� �̻��
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//Connection�� ������ ����� ����
	private static DataSource source;
	static{//static ��� ������ �ʱ�ȭ �� �� �ִ� ����
		try{
			Context init = new InitialContext();//javax.naming
			source = (DataSource)init.lookup("java:comp/env/jdbc/oracle");
		}catch(NamingException e){
			System.out.println("context.xml Ž�� ����");
		}
	}
	
	public BoardDAO(){}
	
	//����޼ҵ�  : �α��α���
	public void connect(){
		try{
			con = source.getConnection();//Connection �뿩
		}catch(Exception e){
			//System.out.println("���� ����");
			e.printStackTrace();//����ó�� ���Ѱ�ó�� ���
		}
	}
	
	//�ڿ��ݳ��޼ҵ�
	public void close(){
		try{
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//������ �۾����� �޼ҵ� ������ ó��
	
	//����� ��쿡�� re_step��꿡 ������ ���߾�� �Ѵ�.
	public boolean insertReply(BoardDTO bdto) throws SQLException{
		String sql = "select (select min(re_step) from board "
				+"where ref=? and re_level=? and re_step>?) " 
				+"as min," 
				+"(select max(re_step) from board "
				+"where ref=? and re_level>? and re_step>?) "
				+"as max from dual";
		try{
			connect();
			ps = con.prepareStatement(sql);
			//����ǥ 6��
			ps.setInt(1, bdto.getRef());
			ps.setInt(2, bdto.getRe_level());
			ps.setInt(3, bdto.getRe_step());
			ps.setInt(4, bdto.getRef());
			ps.setInt(5, bdto.getRe_level());
			ps.setInt(6, bdto.getRe_step());
			rs = ps.executeQuery();
			//rs���� min�̶�� �׸�, max��� �׸� 2���� �ִ�.
			rs.next();
			int row;//���� re_step�� ���� ����
			if(rs.getInt("min")>0){//1�� ������ ����� ������
				//���� ��� 5�� ���Դٸ�?
				row = rs.getInt("min");
				//re_step�� 5�� �ۺ��� ��� re_step 1�� ����(update)
				sql = "update board set re_step = re_step + 1 "
						+ "where ref=? and re_step>=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, bdto.getRef());
				ps.setInt(2, row);
				int result = ps.executeUpdate();//��� ���X
				//�� �� ������ �߰�
			}else{//1�� ������ ����� ���ٸ�
				//2�� ������ ����� Ȯ��
				if(rs.getInt("max")>0){//2�� ������ ����� �ִٸ�
					//����� + 1�� re_step ��ġ�� ������ �߰�
					row = rs.getInt("max")+1;
				}else{//2�� ������ ����� ���ٸ�(��� ����)
					row = bdto.getRe_step()+1;//������ + 1
				}
			}
			
			//������ �߰�
			sql = "insert into board values(board_seq.nextval,"
					+ "?,?,?,?,sysdate,0,0,?,?,?,null,0)";
			ps = con.prepareStatement(sql);
			ps.setString(1, bdto.getWriter());
			ps.setString(2, bdto.getTitle());
			ps.setString(3, bdto.getContent());
			ps.setString(4, bdto.getPw());
			ps.setInt(5, bdto.getRef());//ref : ������ ����
			ps.setInt(6, row);//re_step : ���� ��(row)
			ps.setInt(7, bdto.getRe_level()+1);//re_level : ������ + 1
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	public boolean insertBoard(MultipartRequest mr) 
													throws SQLException{
		String sql = "insert into board values(board_seq.nextval,"
				+ "?,?,?,?,sysdate,0,0,?,?,?,?,?)";
		try{
			int max = findNumber()+1;
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, mr.getParameter("writer"));
			ps.setString(2, mr.getParameter("title"));
			ps.setString(3, mr.getParameter("content"));
			ps.setString(4, mr.getParameter("pw"));
			ps.setInt(5, max);//ref
			ps.setInt(6, 0);//re_step
			ps.setInt(7, 0);//re_level
			//���� ���õ� �� �߰�
			ps.setString(8, mr.getFilesystemName("filename"));//filename
			File file = mr.getFile("filename");
			long filesize = 0L;
			if(file!=null){
				filesize = file.length();
			}
			ps.setLong(9, filesize);//filesize
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//boolean result = bdao.insertBoard(bdto);
	//������ ������ ref�� �������� �Ѵ�.
	public boolean insertBoard(BoardDTO bdto) throws SQLException{
		String sql = "insert into board values(board_seq.nextval,"
								+ "?,?,?,?,sysdate,0,0,?,?,?,null,0)";
		try{
			int max = findNumber()+1;
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, bdto.getWriter());
			ps.setString(2, bdto.getTitle());
			ps.setString(3, bdto.getContent());
			ps.setString(4, bdto.getPw());
			ps.setInt(5, max);//ref
			ps.setInt(6, 0);//re_step
			ps.setInt(7, 0);//re_level
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//int no = bdao.findNumber();
	public int findNumber() throws SQLException{
		String sql = "select max(no) from board";
		try{
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();//�����Ͱ� �ݵ�� 1���� �ִ�
			rs.next();//������ �����Ƿ� �̵��϶�!
			int max = rs.getInt(1);
			return max;
		}finally{
			close();
		}
	}
	
	public ArrayList<BoardDTO> searchBoard
	(String search, String searchString, int start, int end) 
												throws SQLException{
		String sql = "select * from (select rownum rn, "
						+ "A.* from (select * from board where "
						+ search +" like ? order by ref desc, "
						+ "re_step asc)A) "
						+ "where rn between ? and ?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+searchString+"%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			//ArrayList<BoardDTO>�� ����
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//list = bdao.searchBoard(search, searchString);//�˻�
	public ArrayList<BoardDTO> searchBoard
		(String search, String searchString) throws SQLException{
		String sql = "select * from board where "
						+search+" like ? order by no desc";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+searchString+"%");
			rs = ps.executeQuery();
			//ArrayList<BoardDTO>�� ����
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}

	public ArrayList<BoardDTO> listBoard(
				int start, int end) throws SQLException{
		String sql = "select * from (select rownum rn, "
				+ "A.* from (select * from board order "
				+ "by ref desc, re_step asc)A) "
				+ "where rn between ? and ?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//list = bdao.listBoard();//���
	public ArrayList<BoardDTO> listBoard() throws SQLException{
		String sql = "select * from board order by no desc";
		try{
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			ArrayList<BoardDTO> list = makeList(rs);
			return list;
		}finally{
			close();
		}
	}
	
	//ArrayList<BoardDTO> list = makeList(rs);
	public ArrayList<BoardDTO> makeList(ResultSet rs)
													throws SQLException{
		//1. ����� ����
		ArrayList<BoardDTO> list = 
								new ArrayList<BoardDTO>();
		
		//2. rs���� ������ �̵�
		while(rs.next()){
			//2-1. ������ ����
			int no = rs.getInt("no");
			String writer = rs.getString("writer");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String pw = rs.getString("pw");
			String regdate = rs.getString("regdate");
			int readcount = rs.getInt("readcount");
			int recommand = rs.getInt("recommand");
			//��� ���� �׸� �߰��� ����
			int ref = rs.getInt("ref");
			int re_step = rs.getInt("re_step");
			int re_level = rs.getInt("re_level");
			//���� ���� �׸� �߰��� ����
			String filename = rs.getString("filename");
			long filesize = rs.getLong("filesize");
			
			//2-2. ������ ����
			BoardDTO bdto = new BoardDTO(no, writer, title,
				content, pw, regdate, readcount, recommand,
				ref, re_step, re_level, filename, filesize);
			
			//2-3. ������ ���(list)
			list.add(bdto);
		}
		
		//3. list ��ȯ
		return list;
	}
	
	//count = bdao.getBoardCount(search, searchString);
	public int getBoardCount(String search, String searchString)
													throws SQLException{
		String sql = "select count(*) from board where "+search+"=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, searchString);
			rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count;
		}finally{
			close();
		}
	}
	
	//BoardDTO bdto = bdao.getBoard(no);
	public BoardDTO getBoard(int no) throws SQLException{
		String sql = "select * from board where no=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();//������ 1�� �Ǵ� 0��
			ArrayList<BoardDTO> list = makeList(rs);
			//list�� �����Ͱ� �������� ������ �ȴ�
			if(list==null||list.size()==0){
				return null;
			}
			BoardDTO bdto = list.get(0);
			return bdto;
		}finally{
			close();
		}
	}
	
	//bdao.plusCount(no);
	public void plusCount(int no) throws SQLException{
		String sql = "update board "
						+ "set readcount = readcount+1 "
						+ "where no=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			int result = ps.executeUpdate();
		}finally{
			close();
		}
	}
	
	//boolean result = bdao.checkPw(no, pw);
	public boolean checkPw(int no, String pw) throws SQLException{
		String sql = "select no from board where no=? and pw=?";
		//select pw from board where no=?
		//select no from board where no=? and pw=?
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			return rs.next();
		}finally{
			close();
		}
	}
	
	//boolean result = bdao.deleteBoard(no);
	public boolean deleteBoard(int no) throws SQLException{
		String sql = "delete board where no=?";
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
	
	//boolean result = bdao.editBoard(bdto);
	public boolean editBoard(BoardDTO bdto) throws SQLException{
		String sql ="update board set title=?, content=? "
														+ "where no=?";
		try{
			connect();
			ps = con.prepareStatement(sql);
			ps.setString(1, bdto.getTitle());
			ps.setString(2, bdto.getContent());
			ps.setInt(3, bdto.getNo());
			int result = ps.executeUpdate();
			if(result>0) return true;
			else return false;
		}finally{
			close();
		}
	}
	
	//int count = bdao.getBoardCount();
	public int getBoardCount() throws SQLException{
		String sql = "select count(*) from board";
		try{
			connect();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();//������ ������ 1��
			rs.next();
			int count = rs.getInt(1);
			return count;
		}finally{
			close();
		}
	}
}












