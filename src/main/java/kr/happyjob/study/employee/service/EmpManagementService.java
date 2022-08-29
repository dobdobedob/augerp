package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.employee.model.Department;
import kr.happyjob.study.employee.model.EmpManagement;

public interface EmpManagementService {

	List<Department> departmentList() throws Exception;

	List<EmpManagement> listEmpManagementModel(Map<String, Object> paramMap) throws Exception;

	int totEmpManagementModel(Map<String, Object> paramMap) throws Exception;

	EmpManagement selectUserRetire(Map<String, Object> paramMap) throws Exception;

	int saveUserRetire(Map<String, Object> paramMap) throws Exception;

	void insertEmpManagementfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	String selectempManagementID() throws Exception;

	EmpManagement selectempManagementInfo(Map<String, Object> paramMap) throws Exception;

	void updateEmpManagementfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;


}
