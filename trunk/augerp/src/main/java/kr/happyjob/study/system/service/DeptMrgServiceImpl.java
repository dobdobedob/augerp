package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.DeptMrgDao;
import kr.happyjob.study.system.model.DeptMrgModel;


@Service
public class DeptMrgServiceImpl implements DeptMrgService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	DeptMrgDao DeptMrgDao;
	
	
	public List<DeptMrgModel> listDeptMrgModel(Map<String, Object> paramMap) throws Exception {
		
		List<DeptMrgModel> listDeptMrgModel = DeptMrgDao.listDeptMrgModel(paramMap);
		
		return listDeptMrgModel;
	}
	
	public int totdeptMngModel(Map<String, Object> paramMap) throws Exception {
		
		int totdeptMrgModel = DeptMrgDao.totdeptMngModel(paramMap);
		
		return totdeptMrgModel;
	}	
	
    public DeptMrgModel selectDeptMrg(Map<String, Object> paramMap) throws Exception {
		
		DeptMrgModel DeptMrgModel = DeptMrgDao.selectDeptMrg(paramMap);
		
		return DeptMrgModel;
	}
	
    public int insertDeptMrg(Map<String, Object> paramMap) throws Exception {
		
		return DeptMrgDao.insertDeptMrg(paramMap);
	}
    
    public int updateDeptMrg(Map<String, Object> paramMap) throws Exception {
		
		return DeptMrgDao.updateDeptMrg(paramMap);
	}
    
    public int deleteDeptMrg(Map<String, Object> paramMap) throws Exception {
		
		return DeptMrgDao.deleteDeptMrg(paramMap);
	}
    
}
