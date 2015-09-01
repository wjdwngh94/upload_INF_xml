package my.miniboard;

//DTO : Data Transfer Object
//���� ������ �����ϴ� Ŭ����
//DB ���̺�� ������ ���·� �����Ѵ�.
public class MiniDTO {
	private int no;
	private String writer;
	private String content;
	private String joindate;
	//������ �ڵ��ϼ� : �⺻�����ڿ� ��� �Ű������� ���� ������
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
	//Setter&getter : ��� setter/getter �⺻������ ����
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










