package kr.happyjob.study.employee.service;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.employee.dao.IncManageDao;
import kr.happyjob.study.employee.model.IncManageModel;


@Service
public class IncManageServiceImpl implements IncManageService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	IncManageDao IncManageDao;
	
	
	public List<IncManageModel> listIncManageModel(Map<String, Object> paramMap) throws Exception {
		
		List<IncManageModel> listIncManageModel = IncManageDao.listIncManageModel(paramMap);
		
		return listIncManageModel;
	}
	
	public List<IncManageModel> listIncManageiModel(Map<String, Object> paramMap) throws Exception {
		
		List<IncManageModel> listIncManageiModel = IncManageDao.listIncManageiModel(paramMap);
		
		return listIncManageiModel;
	}
	
	public int totIncManageModel(Map<String, Object> paramMap) throws Exception {
		
		int totIncManageModel = IncManageDao.totIncManageModel(paramMap);
		
		return totIncManageModel;
	}	
	
	public int totIncManageiModel(Map<String, Object> paramMap) throws Exception {
		
		int totIncManageiModel = IncManageDao.totIncManageiModel(paramMap);
		
		return totIncManageiModel;
	}
	
    public IncManageModel selectIncManage(Map<String, Object> paramMap) throws Exception {
		
		IncManageModel IncManageModel = IncManageDao.selectIncManage(paramMap);
		
		return IncManageModel;
	}
	
    
    public int updateIncManagereadcnt(Map<String, Object> paramMap) throws Exception {
		
		return IncManageDao.updateIncManagereadcnt(paramMap);
	}
    
    public int insertIncManage(Map<String, Object> paramMap) throws Exception {
		
		return IncManageDao.insertIncManage(paramMap);
	}


	public int updateIncManage(Map<String, Object> paramMap) throws Exception {
		
	
		return IncManageDao.updateIncManage(paramMap);
	}
	
	public String todayDate(Map<String, Object> paramMap) throws Exception {
		return IncManageDao.todayDate(paramMap);
	}
	public String todayDD(Map<String, Object> paramMap) throws Exception {
		return IncManageDao.todayDD(paramMap);
	}
	
	public int saveIncManage(Map<String, Object> paramMap) throws Exception {
		return IncManageDao.saveIncManage(paramMap);
	}
	
}
   