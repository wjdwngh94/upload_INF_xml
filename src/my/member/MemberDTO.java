package my.member;

public class MemberDTO {
	private int no;				//��ȣ
	private String id;			//���̵�
	private String pw;			//��й�ȣ
	private String name;		//�̸�
	private String birth;		//�������
	private String joindate;	//������
	private String gender;		//����
	private String post;			//�����ȣ
	private String addr1;		//�⺻�ּ�
	private String addr2;		//���ּ�
	private String power;		//����
	public MemberDTO() {
		super();
	}
	public MemberDTO(int no, String id, String pw, String name, String birth,
			String joindate, String gender, String post, String addr1,
			String addr2, String power) {
		super();
		this.no = no;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.birth = birth;
		this.joindate = joindate;
		this.gender = gender;
		this.post = post;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.power = power;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPost() {
		if(post==null)	return "";
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getAddr1() {
		if(addr1==null) return "";
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		if(addr2 == null) return "";
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
}



