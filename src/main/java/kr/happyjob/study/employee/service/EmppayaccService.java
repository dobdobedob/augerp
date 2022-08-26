package kr.happyjob.study.employee.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmppayaccModel;


public interface EmppayaccService {

	public EmppayaccModel listEmployeeModel(Map<String, Object> paramMap) throws Exception;
	
	public EmppayaccModel listPayModel(Map<String, Object> paramMap) throws Exception;
	

	
		
}
