package kr.happyjob.study.sales.model;

public class DdRevenueModel {
	
	// 수주날짜
	private String do_date;
	// 기업 코드
	private int cop_no;
    // 기업 명
	private String cop_nm;
    // 직원 코드
	private String loginID;
    // 제품 대분류 명
	private String bi_nm;
    // 제품 명
	private String si_nm;
    // 수주 총액
	private int ord_tot;
    // 미수 금액
	private int ord_ar;
	
	
	public String getDo_date() {
		return do_date;
	}
	public void setDo_date(String do_date) {
		this.do_date = do_date;
	}
	public int getCop_no() {
		return cop_no;
	}
	public void setCop_no(int cop_no) {
		this.cop_no = cop_no;
	}
	public String getCop_nm() {
		return cop_nm;
	}
	public void setCop_nm(String cop_nm) {
		this.cop_nm = cop_nm;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getBi_nm() {
		return bi_nm;
	}
	public void setBi_nm(String bi_nm) {
		this.bi_nm = bi_nm;
	}
	public String getSi_nm() {
		return si_nm;
	}
	public void setSi_nm(String si_nm) {
		this.si_nm = si_nm;
	}
	public int getOrd_tot() {
		return ord_tot;
	}
	public void setOrd_tot(int ord_tot) {
		this.ord_tot = ord_tot;
	}
	public int getOrd_ar() {
		return ord_ar;
	}
	public void setOrd_ar(int ord_ar) {
		this.ord_ar = ord_ar;
	}
}
