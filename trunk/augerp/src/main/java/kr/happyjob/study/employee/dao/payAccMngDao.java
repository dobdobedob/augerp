package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.payAccMngModel;

public interface payAccMngDao {

	public List<payAccMngModel> listpayAccMngModel(Map<String, Object> paramMap) throws Exception;

	public int totpayAccMngModel(Map<String, Object> paramMap) throws Exception;
	
	public payAccMngModel selectpayAccMng(Map<String, Object> paramMap) throws Exception;

	public int updatepayAccMngreadcnt(Map<String, Object> paramMap) throws Exception;

	public int insertpayAccMng(Map<String, Object> paramMap) throws Exception;
	
	public int updatepayAccMng(Map<String, Object> paramMap) throws Exception;

	public int deletepayAccMng(Map<String, Object> paramMap) throws Exception;

	public List<payAccMngModel> listpayAccMngModeldtl(Map<String, Object> paramMap) throws Exception;

	public int countListComnDtlCoddtl(Map<String, Object> paramMap) throws Exception;


	
}
