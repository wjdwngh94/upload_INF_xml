package my.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardDTO {
	//DB ���� ����
	private int no;
	private String writer;
	private String title;
	private String content;
	private String pw;
	private String regdate;
	private int readcount;
	private int recommand;
	/* ��� ���� 3���� ���°� �߰� */
	private int ref;
	private int re_step;
	private int re_level;
	/* ���� ���ε� ���� 2���� ���°� �߰� */
	private String filename;
	private long filesize;
	
	public BoardDTO() {
		super();
	}
	public BoardDTO(int no, String writer, String title, String content,
			String pw, String regdate, int readcount, int recommand, int ref,
			int re_step, int re_level, String filename, long filesize) {
		super();
		this.no = no;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.pw = pw;
		this.regdate = regdate;
		this.readcount = readcount;
		this.recommand = recommand;
		this.ref = ref;
		this.re_step = re_step;
		this.re_level = re_level;
		this.filename = filename;
		this.filesize = filesize;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		//System.out.println("setNo()");
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		//System.out.println("setWriter()");
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		//System.out.println("setTitle()");
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		//System.out.println("setContent()");
		this.content = content;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		//System.out.println("setPw()");
		this.pw = pw;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		//System.out.println("setRegdate()");
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		//System.out.println("setReadcount()");
		this.readcount = readcount;
	}
	public int getRecommand() {
		return recommand;
	}
	public void setRecommand(int recommand) {
		//System.out.println("setRecommand()");
		this.recommand = recommand;
	}
	//�����̸� �ð���, ������ �ۼ������� ��¥�� ��ȯ�ϴ� �޼ҵ�
	public String getTime(){
		//���� �ð��� ���
		Date date = new Date();
		SimpleDateFormat form = 
				new SimpleDateFormat("yyyy-MM-dd");
		String today = form.format(date);
		
		//����� regdate�� ��
		//2015-08-27 14:20:14.0
		String[] arr = regdate.split(" ");
		//arr[0] = "2015-08-27"
		//arr[1] = "14:20:14.0"
		if(today.equals(arr[0])){//������
			return arr[1].substring(0, 5);//�ð� ��ȯ
		}else{//�ٸ���
			return arr[0];//��¥ ��ȯ
		}
	}
}














