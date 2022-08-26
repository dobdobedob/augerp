package kr.happyjob.study.employee.service;


import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpLoginInfoModel;
import kr.happyjob.study.employee.model.EmpTaApplyModel;
import kr.happyjob.study.employee.model.EmpTaApplyRemainVacModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface EmpTaApplyService {

	/* 그룹코드 목록 조회 */
	public List<EmpTaApplyModel> listEmpTaApply(Map<String, Object> paramMap) throws Exception;
	
	/* 그룹코드 목록 카운트 조회 */
	public int countListEmpTaApply(Map<String, Object> paramMap) throws Exception;
	
	/* 로그인 한 사람의 휴가 일수 리스트*/
	public List<EmpTaApplyRemainVacModel> listLoginVac(Map<String, Object> paramMap) throws Exception; 

	/*반려 정보 단건 조회 */
	public EmpTaApplyModel selectEmpDtlApply(Map<String,Object> paramMap) throws Exception; 
	
	/*로그인 정보 조회*/
	public EmpLoginInfoModel empTaLoginInfo(Map<String, Object> paramMap) throws Exception;
	
	/*승인 대기 모달창 정보 단건 조회 */
	public EmpTaApplyModel selectWaitingEmpApply(Map<String,Object> paramMap) throws Exception; 
	
	/** 휴가신청  수정 */
	public int updateEmpTaApply(Map<String, Object> paramMap) throws Exception;
	
	/** 휴가신청 삭제 */
	public int deleteEmpTaApply(Map<String, Object> paramMap) throws Exception;
	
	/* 휴가신청 저장 */
	public int insertEmpTaApply(Map<String, Object> paramMap) throws Exception;
	
	/* 휴가승인 저장 */
	public int approve(Map<String, Object> paramMap) throws Exception;

	/* 휴가반려 저장 */
	public int reject(Map<String, Object> paramMap) throws Exception;

	
}
