package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.ARMDao;
import kr.happyjob.study.sales.model.ARMModel;



@Service
public class ARMServiceImpl implements ARMService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	ARMDao armDao;
	
	
	public List<ARMModel> listARMModel(Map<String, Object> paramMap) throws Exception {
		
		List<ARMModel> listARMModel = armDao.listARMModel(paramMap);
		
		return listARMModel;
	}
	
	public int totARMModel(Map<String, Object> paramMap) throws Exception {
		
		int totARMModel = armDao.totARMModel(paramMap);
		
		return totARMModel;
	}	
	
    public ARMModel selectarm(Map<String, Object> paramMap) throws Exception {
		
    	ARMModel armModel = armDao.selectarm(paramMap);
		
		return armModel;
	}

	
	public int incomeinsert(Map<String, Object> paramMap) throws Exception {
		
		armDao.incomeinsert(paramMap);
		
		return armDao.incomeinsert(paramMap);
	}
	
        
}
