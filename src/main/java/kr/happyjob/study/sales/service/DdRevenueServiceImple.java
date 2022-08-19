package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.DdRevenueDao;
import kr.happyjob.study.sales.model.DdRevenueModel;

@Service
public class DdRevenueServiceImple implements DdRevenueService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DdRevenueDao ddRevenueeDao;	

	public List<DdRevenueModel> listDdRevenueModel(Map<String, Object> paramMap) throws Exception {
		
		List<DdRevenueModel> listDdRevenueModel = ddRevenueeDao.listDdRevenueModel(paramMap);
		
		return listDdRevenueModel;
	};
	
	public int totDdRevenueModel(Map<String, Object> paramMap) throws Exception {
		
		int totDdRevenueModel = ddRevenueeDao.totDdRevenueModel(paramMap);
		
		return totDdRevenueModel;
		
	};	
}
