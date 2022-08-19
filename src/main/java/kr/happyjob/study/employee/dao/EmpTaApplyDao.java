package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpTaApplyModel;
import kr.happyjob.study.employee.model.EmpTaApplyRemainVacModel;

public interface EmpTaApplyDao {

	int countListEmpTaApply(Map<String, Object> paramMap);

	List<EmpTaApplyModel> listEmpTaApply(Map<String, Object> paramMap);

	List<EmpTaApplyRemainVacModel> listLoginVac(Map<String,Object> paramMap); 
	
	
}
