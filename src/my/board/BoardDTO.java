package my.board;

public class BoardDTO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String pw;
	private String regdate;
	private int readcount;
	private int recommand;

	public BoardDTO() {
		super();
	}

	public BoardDTO(int no, String writer, String title, String content,
			String pw, String regdate, int readcount, int recommand) {
		super();
		this.no = no;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.pw = pw;
		this.regdate = regdate;
		this.readcount = readcount;
		this.recommand = recommand;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getRegdate() {
		return regdate;
	}
	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRecommand() {
		return recommand;
	}

	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}
}
