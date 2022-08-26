package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpLoginInfoModel;
import kr.happyjob.study.employee.model.EmpTaApplyModel;
import kr.happyjob.study.employee.model.EmpTaApplyRemainVacModel;

public interface EmpTaApplyDao {

	int countListEmpTaApply(Map<String, Object> paramMap);

	List<EmpTaApplyModel> listEmpTaApply(Map<String, Object> paramMap);

	List<EmpTaApplyRemainVacModel> listLoginVac(Map<String,Object> paramMap);

	EmpTaApplyModel selectEmpDtlApply(Map<String, Object> paramMap); 
	
	EmpTaApplyModel selectWaitingEmpApply(Map<String, Object> paramMap); 
	
	EmpLoginInfoModel empTaLoginInfo(Map<String, Object> paramMap);
	
	int insertEmpTaApply(Map<String, Object> paramMap);
	
	int deleteEmpTaApply(Map<String, Object> paramMap);
	
	int updateEmpTaApply(Map<String, Object> paramMap);
	
	int approve(Map<String, Object> paramMap);
	
	int reject(Map<String, Object> paramMap);
	
}

