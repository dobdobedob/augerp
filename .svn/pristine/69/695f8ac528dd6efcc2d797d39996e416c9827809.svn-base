package kr.happyjob.study.accounting.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accounting.dao.DVApproveDao;
import kr.happyjob.study.accounting.model.EmpDvModel;

@Service
public class DVApproveServiceImpl implements DVApproveService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticeimage}")
	private String empManagementPath;
	
	@Autowired
	DVApproveDao dVApproveDao;	
	
	public List<EmpDvModel> listDVApprove(Map<String, Object> paramMap) throws Exception {
		List<EmpDvModel> listDVApprove = dVApproveDao.listDVApprove(paramMap);
		return listDVApprove;
	}

	public int countListDVApprove(Map<String, Object> paramMap) throws Exception {
		int totalCount = dVApproveDao.countListDVApprove(paramMap);
		return totalCount;
	}

	public EmpDvModel empDVApproveModal(Map<String, Object> paramMap) throws Exception {
		
		EmpDvModel empDvOneModel = dVApproveDao.empDVApproveModal(paramMap);
		
		return empDvOneModel;
	}

	public int updateDVApprove(Map<String, Object> paramMap) throws Exception {
		
		
		int updateDVA = dVApproveDao.updateDVApprove(paramMap);
		return updateDVA;
	}

}
