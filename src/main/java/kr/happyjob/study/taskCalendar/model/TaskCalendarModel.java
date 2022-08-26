package kr.happyjob.study.taskCalendar.model;

import java.util.Date;

public class TaskCalendarModel {
	
	//tb_userInfo table에서 가져오는 정보들
	private String loginID; //사용자 ID == 사원번호
	private String user_type; //사용자구분 == 직무
	private String name; //사원명
	private String tel; //연락처
	private String dept_cd; //부서코드
	private String job_cd; //직급코드 -> 공통코드table
	
	//tb_dept
	private String dept_name; //부서명
	
	//tb_vacation_request
	private int vac_no; // 신청번호
	private String vac_bo; //승인자
	private String vac_stat; //승인여부
	private String vac_rdate; //신청일자
	private String vac_type; //근태종류
	private String vac_re; //근태사유
	private String vac_sdate; //시작일자
	private String vac_edate; //종료일자
	private String vac_rere; //반려사유
	
	private int vac_cnt; //캘린더에서 승인 여부에 따라 건 수 가져올 때 필요한 변수

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getJob_cd() {
		return job_cd;
	}

	public void setJob_cd(String job_cd) {
		this.job_cd = job_cd;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public int getVac_no() {
		return vac_no;
	}

	public void setVac_no(int vac_no) {
		this.vac_no = vac_no;
	}

	public String getVac_bo() {
		return vac_bo;
	}

	public void setVac_bo(String vac_bo) {
		this.vac_bo = vac_bo;
	}

	public String getVac_stat() {
		return vac_stat;
	}

	public void setVac_stat(String vac_stat) {
		this.vac_stat = vac_stat;
	}

	public String getVac_rdate() {
		return vac_rdate;
	}

	public void setVac_rdate(String vac_rdate) {
		this.vac_rdate = vac_rdate;
	}

	public String getVac_type() {
		return vac_type;
	}
	
	public void setVac_type(String vac_type) {
		this.vac_type = vac_type;
	}

	public String getVac_re() {
		return vac_re;
	}

	public void setVac_re(String vac_re) {
		this.vac_re = vac_re;
	}

	public String getVac_sdate() {
		return vac_sdate;
	}

	public void setVac_sdate(String vac_sdate) {
		this.vac_sdate = vac_sdate;
	}

	public String getVac_edate() {
		return vac_edate;
	}

	public void setVac_edate(String vac_edate) {
		this.vac_edate = vac_edate;
	}

	public String getVac_rere() {
		return vac_rere;
	}

	public void setVac_rere(String vac_rere) {
		this.vac_rere = vac_rere;
	}

	public int getVac_cnt() {
		return vac_cnt;
	}

	public void setVac_cnt(int vac_cnt) {
		this.vac_cnt = vac_cnt;
	}

	@Override
	public String toString() {
		return "taskCalendarModel [loginID=" + loginID + ", user_type=" + user_type + ", name=" + name + ", tel=" + tel
				+ ", dept_cd=" + dept_cd + ", job_cd=" + job_cd + ", dept_name="+ dept_name + ", vac_bo=" + vac_bo + ", vac_bo=" 
				+ vac_bo + ", vac_stat=" + vac_stat + ", vac_rdate="+ vac_rdate + ", vac_type=" + vac_type + ", vac_re=" + vac_re 
				+ ", vac_sdate=" + vac_sdate+ ", vac_edate=" + vac_edate + ", vac_rere=" + vac_rere + ", vac_cnt="+ vac_cnt + "]";
	}


	
}
