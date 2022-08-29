package kr.happyjob.study.business.model;

public class BizPartnerModel {
	
	private int cop_no;//거래처 코드
	private String loginID;//우리 담당직원
	private String loginNM;//우리담당직원 이름
	private String cop_nm;//업체명
	private String cop_tel;//회사 전화번호 -> partnerTel1,2,3이 합쳐져서 보내져야 한다.
	private String cop_ee;// 상대담당자
	private String cop_bm;//대표자명
	private String cop_phn;//휴대전화->partnerPh1,2,3이 합쳐져서 보냊뎌야 한다.
	private String cop_zip;//우편번호
	private String cop_addr;//주소
	private String cop_daddr;//상세주소
	private String cop_email;//대표 이메일
	private String cop_cno;//사업자 등록번호
	private String cop_anm;//예금자명
	private String cop_bcd;//은행 코드 
	private String cop_ano;//계좌 번호
	private String cop_memo;//기타 메모
	private String cop_date;//생성날짜
	
	public int getCop_no() {
		return cop_no;
	}
	public void setCop_no(int cop_no) {
		this.cop_no = cop_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getCop_nm() {
		return cop_nm;
	}
	public void setCop_nm(String cop_nm) {
		this.cop_nm = cop_nm;
	}
	public String getCop_tel() {
		return cop_tel;
	}
	public void setCop_tel(String cop_tel) {
		this.cop_tel = cop_tel;
	}
	public String getCop_ee() {
		return cop_ee;
	}
	public void setCop_ee(String cop_ee) {
		this.cop_ee = cop_ee;
	}
	public String getCop_bm() {
		return cop_bm;
	}
	public void setCop_bm(String cop_bm) {
		this.cop_bm = cop_bm;
	}
	public String getCop_phn() {
		return cop_phn;
	}
	public void setCop_phn(String cop_phn) {
		this.cop_phn = cop_phn;
	}
	public String getCop_zip() {
		return cop_zip;
	}
	public void setCop_zip(String cop_zip) {
		this.cop_zip = cop_zip;
	}
	public String getCop_addr() {
		return cop_addr;
	}
	public void setCop_addr(String cop_addr) {
		this.cop_addr = cop_addr;
	}
	public String getCop_daddr() {
		return cop_daddr;
	}
	public void setCop_daddr(String cop_daddr) {
		this.cop_daddr = cop_daddr;
	}
	public String getCop_email() {
		return cop_email;
	}
	public void setCop_email(String cop_email) {
		this.cop_email = cop_email;
	}
	public String getCop_cno() {
		return cop_cno;
	}
	public void setCop_cno(String cop_cno) {
		this.cop_cno = cop_cno;
	}
	public String getCop_anm() {
		return cop_anm;
	}
	public void setCop_anm(String cop_anm) {
		this.cop_anm = cop_anm;
	}
	public String getCop_bcd() {
		return cop_bcd;
	}
	public void setCop_bcd(String cop_bcd) {
		this.cop_bcd = cop_bcd;
	}
	public String getCop_ano() {
		return cop_ano;
	}
	public void setCop_ano(String cop_ano) {
		this.cop_ano = cop_ano;
	}
	public String getCop_memo() {
		return cop_memo;
	}
	public void setCop_memo(String cop_memo) {
		this.cop_memo = cop_memo;
	}
	public String getCop_date() {
		return cop_date;
	}
	public void setCop_date(String cop_date) {
		this.cop_date = cop_date;
	}
	public String getLoginNM() {
		return loginNM;
	}
	public void setLoginNM(String loginNM) {
		this.loginNM = loginNM;
	}
	
	
	

}
