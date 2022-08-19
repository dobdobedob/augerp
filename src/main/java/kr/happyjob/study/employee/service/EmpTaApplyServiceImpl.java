package kr.happyjob.study.employee.service;

import java.util.List;


import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.employee.dao.EmpTaApplyDao;
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
	
	
	
	
	
	
	
	/**//** 그룹코드 단건 조회 *//*
	public ComnGrpCodModel selectComnGrpCod(Map<String, Object> paramMap) throws Exception {
		
		ComnGrpCodModel comnGrpCodModel = comnCodDao.selectComnGrpCod(paramMap);
		return comnGrpCodModel;
	}
	
	*//** 그룹코드 저장 *//*
	public int insertComnGrpCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.insertComnGrpCod(paramMap);
		
		return ret;
	}
	
	*//** 그룹코드 수정 *//*
	public int updateComnGrpCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.updateComnGrpCod(paramMap);
		return ret;
	}
	
	*//** 그룹코드 삭제 *//*
	public int deleteComnGrpCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.deleteComnGrpCod(paramMap);
		
		return ret;
	}
	
	*//** 상세코드 목록 조회 *//*
	public List<ComnDtlCodModel> listComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		List<ComnDtlCodModel> listComnGrpCod = comnCodDao.listComnDtlCod(paramMap);
		
		return listComnGrpCod;
	}
	
	*//** 그룹코드 목록 카운트 조회 *//*
	public int countListComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = comnCodDao.countListComnDtlCod(paramMap);
		
		return totalCount;
	}
	
	*//** 상세코드 단건 조회 *//*
	public ComnDtlCodModel selectComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		ComnDtlCodModel comnDtlCodModel = comnCodDao.selectComnDtlCod(paramMap);
		return comnDtlCodModel;
	}
	
	*//** 상세코드 저장 *//*
	public int insertComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.insertComnDtlCod(paramMap);
		return ret;
	}
	
	*//** 상세코드 수정 *//*
	public int updateComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.updateComnDtlCod(paramMap);
		return ret;
	}
	
	*//** 상세코드 삭제 *//*
	public int deleteComnDtlCod(Map<String, Object> paramMap) throws Exception {
		
		int ret = comnCodDao.deleteComnDtlCod(paramMap);
		return ret;
	}
	
	*//** 사용가능한 모든 공통코드 조회 *//*
	public List<ComnCodUtilModel> listAllComnCode(Map<String, Object> paramMap) throws Exception {
		
		List<ComnCodUtilModel> listComnCode = comnCodDao.listAllComnCode(paramMap);
		return listComnCode;
	}*/
	
		
	
	
}
