package kr.happyjob.study.employee.model;

public class EmpPromotion {

	private String hr_no;//이력코드 
	private String loginID;//사용자ID
	private String dept_cd;//부서코드 
	private String dept_name;//부서명
	private String job_cd;//직급코드
	private String detail_name;//직급명
	private String hr_date;//등록일자
	private String name;//사용자명
	
	public String getHr_no() {
		return hr_no;
	}
	public void setHr_no(String hr_no) {
		this.hr_no = hr_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public String getHr_date() {
		return hr_date;
	}
	public void setHr_date(String hr_date) {
		this.hr_date = hr_date;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
