package my.db;
import java.sql.*;
import java.util.*;
public class ConnectionPoolBean {
	//������ DAO���� �ϴ� DB������ ���� ���þ� �ϰڴ�...
	//DB ���� ������ ��� ������ ���� ���´�.
	private String url, user, pass;
	private Hashtable<Connection, Boolean> ht;//pool�� �����
	private int increment;//����ġ(���ڸ��� �߰��� ����)
	
	public ConnectionPoolBean() throws ClassNotFoundException, SQLException {
		increment = 3;//����ġ 3���� ����
		ht = new Hashtable<Connection, Boolean>(5);//���� 5ĭ
		url = "jdbc:oracle:thin:@localhost:1521:xe";
		user = "jsp1";
		pass = "jsp1";
		
		//����̹� ����
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		//Connection 5�� ���� �� ht�� �߰�
		for(int i=0; i<5; ++i){
			Connection con = DriverManager.getConnection(url, user, pass);
			ht.put(con, Boolean.FALSE);//��� con��ü�� ����
		}
	}
	
	//Ȯ�ο� �޼ҵ�
	public void printCon(){
		int total=0, work=0, non_work=0;
		Enumeration<Boolean> enu = ht.elements();
		while(enu.hasMoreElements()){
			Boolean bool = enu.nextElement();
			total++;
			if(bool) work++;
			else non_work++;
		}
		System.out.printf("���� : %d , ��� : %d , ���� : %d\n",total, work, non_work);
	}

	//getConnection() �� ȣ���ϸ� Connection �Ѱ��� �뿩�� �� �ִ�.
	//1. ht���� ����ִ� Connection�� ã�´�.(������ ��ȯ���ְ� ���ϰ� �ִٰ� ǥ��)
	//2. ���࿡ Connection�� ���ڸ��� increment��ŭ ������Ų��.
	public synchronized Connection getConnection() throws SQLException {
		Enumeration<Connection> enkey = ht.keys();
		Connection con = null;
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			Boolean b = ht.get(con);
			if (b == Boolean.FALSE){//��� �ִ� Connection�� �߰��ϸ�
				ht.put(con, Boolean.TRUE);//���ϰ� �ִ� ���·� �����ϰ�
				printCon();
				return con;//�뿩���ش�.
			}
		}
		
		//����ִ� Connection�� �����Ƿ� �߰� ����
		for(int i=0; i<increment; ++i){
			Connection con2 = DriverManager.getConnection(url, user, pass);
			ht.put(con2, Boolean.FALSE);
			printCon();
		}
		return getConnection();
		//�߰� increment��ŭ ������ �� ���ȣ��
	}
	
	//�뿩���� Connection�� �ݳ��޴� �޼ҵ�
	public void returnConnection(Connection returnCon) throws SQLException{
		Connection con = null;
		Enumeration<Connection> enkey = ht.keys();
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			if (returnCon == con) {//�ݳ����� Connection��
				ht.put(con, Boolean.FALSE);//��� �ִٰ� �����ϰ�
				printCon();
				break;
			}
		}
		removeCon();
	}
	
	//��� �ִ� Connection�� 5���� ���ΰ� �� ���������� �޼ҵ�
	public void removeCon() throws SQLException {
		int count = 0;//��� ��ü ���� ī��Ʈ ����
		Connection con = null;
		Enumeration<Connection> enkey = ht.keys();
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			Boolean b = ht.get(con);
			if(b == Boolean.FALSE){
				count++;
				if(count>5){
					ht.remove(con);
					printCon();
					con.close();
				}
			}
		}
	}
	
	public void closeAll() throws SQLException {
		Connection con = null;
		Enumeration<Connection> enkey = ht.keys();
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			con.close();
			printCon();
		}
	}
}









