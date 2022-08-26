package kr.happyjob.study.employee.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.employee.dao.payAccMngDao;
import kr.happyjob.study.employee.model.payAccMngModel;


@Service
public class payAccMngServiceImpl implements payAccMngService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	payAccMngDao payAccMngDao;
	
	
	public List<payAccMngModel> listpayAccMngModel(Map<String, Object> paramMap) throws Exception {
		
		List<payAccMngModel> listpayAccMngModel = payAccMngDao.listpayAccMngModel(paramMap);
		
		return listpayAccMngModel;
	}
	
	public int totpayAccMngModel(Map<String, Object> paramMap) throws Exception {
		
		int totpayAccMngModel = payAccMngDao.totpayAccMngModel(paramMap);
		
		return totpayAccMngModel;
	}	
	
    public payAccMngModel selectpayAccMng(Map<String, Object> paramMap) throws Exception {
		
		payAccMngModel payAccMngModel = payAccMngDao.selectpayAccMng(paramMap);
		
		return payAccMngModel;
	}
	
    
    public int updatepayAccMngreadcnt(Map<String, Object> paramMap) throws Exception {
		
		return payAccMngDao.updatepayAccMngreadcnt(paramMap);
	}
    
    public int insertpayAccMng(Map<String, Object> paramMap) throws Exception {
		
		return payAccMngDao.insertpayAccMng(paramMap);
	}
    
    public int updatepayAccMng(Map<String, Object> paramMap) throws Exception {
		
		return payAccMngDao.updatepayAccMng(paramMap);
	}
    
    public int deletepayAccMng(Map<String, Object> paramMap) throws Exception {
		
		return payAccMngDao.deletepayAccMng(paramMap);
	}

	@Override
	public int countListComnDtlCod(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	
	public List<payAccMngModel> listpayAccMngModeldtl(Map<String, Object> paramMap) throws Exception {
		 List<payAccMngModel> listpayAccMngModeldtl = payAccMngDao.listpayAccMngModeldtl(paramMap);
		return listpayAccMngModeldtl;
	}

	public int countListComnDtlCoddtl(Map<String, Object> paramMap) throws Exception {
		return payAccMngDao.countListComnDtlCoddtl(paramMap);
	}

    
		
		
}
