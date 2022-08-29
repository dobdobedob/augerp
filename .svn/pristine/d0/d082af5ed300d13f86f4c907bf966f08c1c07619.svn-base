package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpPromotionDao;
import kr.happyjob.study.employee.model.EmpManagement;
import kr.happyjob.study.employee.model.EmpPromotion;

@Service
public class EmpPromotionServiceImpl implements EmpPromotionService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	EmpPromotionDao empPromotionDao;
	
	
	public List<EmpPromotion> empPromotionModalList(Map<String, Object> paramMap) throws Exception {
		
		List<EmpPromotion> empPromotionModalList = empPromotionDao.empPromotionModalList(paramMap);
		
		return empPromotionModalList;
	}

	public int totEmpPromotionModel(Map<String, Object> paramMap) throws Exception {
		
		return empPromotionDao.totEmpPromotionModel(paramMap);
	}

	public List<EmpPromotion> empPromotionModalListlogin(Map<String, Object> paramMap) throws Exception {
		
		List<EmpPromotion> empPromotionModalListlogin = empPromotionDao.empPromotionModalListlogin(paramMap);
		
		return empPromotionModalListlogin;
	}

	public int totEmpPromotionModellogin(Map<String, Object> paramMap) throws Exception {
		
		return empPromotionDao.totEmpPromotionModellogin(paramMap);
	}

	public EmpManagement empManagementinfo(Map<String, Object> paramMap) throws Exception {
		
		return empPromotionDao.empManagementinfo(paramMap);
	}
}
