package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.MmRevenueDao;
import kr.happyjob.study.sales.model.MmRevenueModel;

@Service
public class MmRevenueServiceImple implements MmRevenueService{
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MmRevenueDao mmRevenueeDao;

	public List<MmRevenueModel> listMmRevenueModel(Map<String, Object> paramMap) throws Exception {
		
		List<MmRevenueModel> listMmRevenueModel = mmRevenueeDao.listMmRevenueModel(paramMap);
		
		return listMmRevenueModel;
	};
	
	public int totMmRevenueModel(Map<String, Object> paramMap) throws Exception {
		
		int totMmRevenueModel = mmRevenueeDao.totMmRevenueModel(paramMap);
		
		return totMmRevenueModel;
		
	};		
}
