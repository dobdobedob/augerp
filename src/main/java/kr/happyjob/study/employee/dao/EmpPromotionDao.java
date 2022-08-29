package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmpManagement;
import kr.happyjob.study.employee.model.EmpPromotion;

public interface EmpPromotionDao {

	List<EmpPromotion> empPromotionModalList(Map<String, Object> paramMap) throws Exception;

	int totEmpPromotionModel(Map<String, Object> paramMap) throws Exception;

	List<EmpPromotion> empPromotionModalListlogin(Map<String, Object> paramMap) throws Exception;

	int totEmpPromotionModellogin(Map<String, Object> paramMap) throws Exception;

	EmpManagement empManagementinfo(Map<String, Object> paramMap) throws Exception;

}
