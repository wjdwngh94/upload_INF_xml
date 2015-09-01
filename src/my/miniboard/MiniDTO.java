package my.miniboard;

//DTO : Data Transfer Object
//포장 역할을 수행하는 클래스
//DB 테이블과 동일한 형태로 생성한다.
public class MiniDTO {
	private int no;
	private String writer;
	private String content;
	private String joindate;
	//생성자 자동완성 : 기본생성자와 모든 매개변수를 갖는 생성자
	//Source -> Generate Constructor using fields
	public MiniDTO() {
		super();
	}
	public MiniDTO(int no, String writer, String content, String joindate) {
		super();
		this.no = no;
		this.writer = writer;
		this.content = content;
		this.joindate = joindate;
	}
	//Setter&getter : 모든 setter/getter 기본적으로 생성
	//Source -> Generate Getters and Setters
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
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
}










