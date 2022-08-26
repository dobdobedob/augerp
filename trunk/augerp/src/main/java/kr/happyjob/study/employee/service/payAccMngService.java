package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.employee.model.payAccMngModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.NoticeModel;

public interface payAccMngService {
	public List<payAccMngModel> listpayAccMngModel(Map<String, Object> paramMap) throws Exception;
	
	public payAccMngModel selectpayAccMng(Map<String, Object> paramMap) throws Exception;

	public int updatepayAccMngreadcnt(Map<String, Object> paramMap) throws Exception;

	public int insertpayAccMng(Map<String, Object> paramMap) throws Exception;
	
	public int updatepayAccMng(Map<String, Object> paramMap) throws Exception;

	public int deletepayAccMng(Map<String, Object> paramMap) throws Exception;

	public int countListComnDtlCod(Map<String, Object> paramMap)throws Exception;

	public int totpayAccMngModel(Map<String, Object> paramMap)throws Exception;

	public List<payAccMngModel> listpayAccMngModeldtl(Map<String, Object> paramMap)throws Exception;

	public int countListComnDtlCoddtl(Map<String, Object> paramMap)throws Exception;


}
