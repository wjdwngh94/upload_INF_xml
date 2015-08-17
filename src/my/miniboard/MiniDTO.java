package my.miniboard;

//DTO : DATA TRANSFER OBJECT 포장 역할을 수행하는 클래스
//데이터 베이스에 존재하는 항목들을 담아야 함으로 DB와 똑같은 형태로 만든다.
//일반적으로 DAO와 DTO는 DB TABLE의 수와 같게 만든다.
public class MiniDTO {
	private int no;
	private String writer;
	private String content;
	private String regdate;

	//생성자 자동 완성 : 기본생성자와 모든 매개변수를 갖는 생성장
	//Source -> Generator Constructor using fields
	
	//Setter & Getter : 모든 setter/getter 기본적으로 생성후 걸러낸다.
	//Source -> Generator Getters and Setters
	
	public MiniDTO(int no, String writer, String content, String regdate) {
		super();
		this.no = no;
		this.writer = writer;
		this.content = content;
		this.regdate = regdate;
	}
	public MiniDTO() {
		super();
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
