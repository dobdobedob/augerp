package kr.happyjob.study.business.model;

public class OeManagementModel {

	private String loginID; 
	private String do_date; 
	private String name; 
	private String cop_nm; 
	private int si_cd; 
	private String do_due; 
	private int do_nmt; 
	private int ord_tot; 
	private int tax_amount; 
	private int do_price;
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getDo_date() {
		return do_date;
	}
	public void setDo_date(String do_date) {
		this.do_date = do_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCop_nm() {
		return cop_nm;
	}
	public void setCop_nm(String cop_nm) {
		this.cop_nm = cop_nm;
	}
	public int getSi_cd() {
		return si_cd;
	}
	public void setSi_cd(int si_cd) {
		this.si_cd = si_cd;
	}
	public String getDo_due() {
		return do_due;
	}
	public void setDo_due(String do_due) {
		this.do_due = do_due;
	}
	public int getDo_nmt() {
		return do_nmt;
	}
	public void setDo_nmt(int do_nmt) {
		this.do_nmt = do_nmt;
	}
	public int getOrd_tot() {
		return ord_tot;
	}
	public void setOrd_tot(int ord_tot) {
		this.ord_tot = ord_tot;
	}
	public int getTax_amount() {
		return tax_amount;
	}
	public void setTax_amount(int tax_amount) {
		this.tax_amount = tax_amount;
	}
	public int getDo_price() {
		return do_price;
	}
	public void setDo_price(int do_price) {
		this.do_price = do_price;
	}
	
}
