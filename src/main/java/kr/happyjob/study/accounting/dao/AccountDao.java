package kr.happyjob.study.accounting.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accounting.model.AccountModel;

public interface AccountDao {

	public List<AccountModel> listAccountModel(Map<String, Object> paramMap) throws Exception;

	public int totAccountModel(Map<String, Object> paramMap) throws Exception;
	
	public AccountModel selectaccount(Map<String, Object> paramMap) throws Exception;
	
	public AccountModel selectcopinfo(Map<String, Object> paramMap) throws Exception;
	
	
}
