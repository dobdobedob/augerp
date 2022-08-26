package kr.happyjob.study.employee.service;

import java.util.List;


import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpTaApplyDao;
import kr.happyjob.study.employee.model.EmpLoginInfoModel;
import kr.happyjob.study.employee.model.EmpTaApplyModel;
import kr.happyjob.study.employee.model.EmpTaApplyRemainVacModel;

@Service
public class EmpTaApplyServiceImpl implements EmpTaApplyService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	EmpTaApplyDao empTaApplyDao;
	
	/* 휴가신청리스트 목록 조회 */
	public List<EmpTaApplyModel> listEmpTaApply(Map<String, Object> paramMap) throws Exception {
		
		List<EmpTaApplyModel> listEmpTaApply = empTaApplyDao.listEmpTaApply(paramMap);
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@listEmpTaApply Service"+listEmpTaApply);
		return listEmpTaApply;
	}
	
	/* 휴가신청리스트 목록 카운트 조회 */
	public int countListEmpTaApply(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = empTaApplyDao.countListEmpTaApply(paramMap);
		
		return totalCount;
	}
	
	/*로그인한 사람의 휴가 신청 잔여 횟수*/
	/* 그룹코드 목록 조회 */
	public List<EmpTaApplyRemainVacModel> listLoginVac(Map<String, Object> paramMap) throws Exception {
		
		List<EmpTaApplyRemainVacModel> listLoginVac = empTaApplyDao.listLoginVac(paramMap);
		
		return listLoginVac;
	}
	
	/*반려 select 조회 */
	public EmpTaApplyModel selectEmpDtlApply(Map<String,Object> paramMap) throws Exception{
		
		EmpTaApplyModel empDtlTaApplyModel = empTaApplyDao.selectEmpDtlApply(paramMap);
		
		return empDtlTaApplyModel; 
	}
	
	/*로그인한 사람 기본 정보 조회 */
	public EmpLoginInfoModel empTaLoginInfo(Map<String, Object> paramMap) throws Exception{
		
		EmpLoginInfoModel empDtlTaApplyModel = empTaApplyDao.empTaLoginInfo(paramMap);
		
		return empDtlTaApplyModel; 
		
	}
	
	
	/*승인 대기 정보 단건 모달창 조회 */
	public EmpTaApplyModel selectWaitingEmpApply(Map<String,Object> paramMap)throws Exception{ 
		
		EmpTaApplyModel empDtlTaApplyModel = empTaApplyDao.selectWaitingEmpApply(paramMap);
		
		return empDtlTaApplyModel;
		
	}
	
	/** 그룹코드 저장 */
	public int insertEmpTaApply(Map<String, Object> paramMap) throws Exception {
		
		int ret = empTaApplyDao.insertEmpTaApply(paramMap);
		
		return ret;
	}
	
	/* 그룹코드 수정 */
	public int updateEmpTaApply(Map<String, Object> paramMap) throws Exception {
		
		int ret = empTaApplyDao.updateEmpTaApply(paramMap);
		return ret;
	}
	
	/* 그룹코드 삭제 */
	public int deleteEmpTaApply(Map<String, Object> paramMap) throws Exception {
		
		int ret = empTaApplyDao.deleteEmpTaApply(paramMap);
		
		return ret;
	}
	
public int approve(Map<String, Object> paramMap) throws Exception {
		
		int ret = empTaApplyDao.approve(paramMap);
		
		return ret;
	}
public int reject(Map<String, Object> paramMap) throws Exception {
		
		int ret = empTaApplyDao.reject(paramMap);
		
		return ret;
	}
	
	
}
