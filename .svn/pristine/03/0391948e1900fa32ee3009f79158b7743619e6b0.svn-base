package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.BmSalePlaneDao;
import kr.happyjob.study.business.model.BmSalePlanModel;

@Service
public class BmSalePlanServiceImpl implements BmSalePlanService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BmSalePlaneDao bmsaleplaneDao;
	
	
	public List<BmSalePlanModel> listBmSalePlaneModel(Map<String, Object> paramMap) throws Exception {
		
		List<BmSalePlanModel> listBmSalePlaneModel = bmsaleplaneDao.listBmSalePlaneModel(paramMap);
		
		return listBmSalePlaneModel;
	};
	
	public int totBmSalePlanModel(Map<String, Object> paramMap) throws Exception {
		
		int totBmSalePlanModel = bmsaleplaneDao.totBmSalePlanModel(paramMap);
		
		return totBmSalePlanModel;
		
	};
	
}
