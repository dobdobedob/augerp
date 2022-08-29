package kr.happyjob.study.accounting.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accounting.dao.AccountDao;
import kr.happyjob.study.accounting.model.AccountModel;



@Service
public class AccountServiceImpl implements AccountService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	AccountDao accountDao;
	
	
	public List<AccountModel> listAccountModel(Map<String, Object> paramMap) throws Exception {
		
		List<AccountModel> listAccountModel = accountDao.listAccountModel(paramMap);
		
		return listAccountModel;
	}
	
	public int totAccountModel(Map<String, Object> paramMap) throws Exception {
		
		int totAccountModel = accountDao.totAccountModel(paramMap);
		
		return totAccountModel;
	}	
	
    public AccountModel selectaccount(Map<String, Object> paramMap) throws Exception {
		
    	AccountModel accountModel = accountDao.selectaccount(paramMap);
		
		return accountModel;
	}
    
    
    public AccountModel selectcopinfo(Map<String, Object> paramMap) throws Exception {
		
    	AccountModel accountModel = accountDao.selectcopinfo(paramMap);
		
		return accountModel;
	}
    
}
