package my.db;
import java.sql.*;
import java.util.*;
public class ConnectionPoolBean {
	//기존에 DAO에서 하던 DB연결을 내가 도맡아 하겠다...
	//DB 연결 정보는 모두 나에게 적어 놓는다.
	private String url, user, pass;
	private Hashtable<Connection, Boolean> ht;//pool장 만들기
	private int increment;//증가치(모자르면 추가할 개수)
	
	public ConnectionPoolBean() throws ClassNotFoundException, SQLException {
		increment = 3;//증가치 3으로 설정
		ht = new Hashtable<Connection, Boolean>(5);//최초 5칸
		url = "jdbc:oracle:thin:@localhost:1521:xe";
		user = "jsp1";
		pass = "jsp1";
		
		//드라이버 연결
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		//Connection 5개 생성 후 ht에 추가
		for(int i=0; i<5; ++i){
			Connection con = DriverManager.getConnection(url, user, pass);
			ht.put(con, Boolean.FALSE);//노는 con객체를 생성
		}
	}
	
	//확인용 메소드
	public void printCon(){
		int total=0, work=0, non_work=0;
		Enumeration<Boolean> enu = ht.elements();
		while(enu.hasMoreElements()){
			Boolean bool = enu.nextElement();
			total++;
			if(bool) work++;
			else non_work++;
		}
		System.out.printf("연결 : %d , 사용 : %d , 비사용 : %d\n",total, work, non_work);
	}

	//getConnection() 을 호출하면 Connection 한개를 대여할 수 있다.
	//1. ht에서 놀고있는 Connection을 찾는다.(있으면 반환해주고 일하고 있다고 표시)
	//2. 만약에 Connection이 모자르면 increment만큼 증가시킨다.
	public synchronized Connection getConnection() throws SQLException {
		Enumeration<Connection> enkey = ht.keys();
		Connection con = null;
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			Boolean b = ht.get(con);
			if (b == Boolean.FALSE){//놀고 있는 Connection을 발견하면
				ht.put(con, Boolean.TRUE);//일하고 있는 상태로 수정하고
				printCon();
				return con;//대여해준다.
			}
		}
		
		//놀고있는 Connection이 없으므로 추가 생성
		for(int i=0; i<increment; ++i){
			Connection con2 = DriverManager.getConnection(url, user, pass);
			ht.put(con2, Boolean.FALSE);
			printCon();
		}
		return getConnection();
		//추가 increment만큼 생성한 후 재귀호출
	}
	
	//대여해준 Connection을 반납받는 메소드
	public void returnConnection(Connection returnCon) throws SQLException{
		Connection con = null;
		Enumeration<Connection> enkey = ht.keys();
		while(enkey.hasMoreElements()){
			con = enkey.nextElement();
			if (returnCon == con) {//반납받은 Connection을
				ht.put(con, Boolean.FALSE);//놀고 있다고 변경하고
				printCon();
				break;
			}
		}
		removeCon();
	}
	
	//놀고 있는 Connection을 5개만 놔두고 다 지워버리는 메소드
	public void removeCon() throws SQLException {
		int count = 0;//노는 객체 숫자 카운트 변수
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









