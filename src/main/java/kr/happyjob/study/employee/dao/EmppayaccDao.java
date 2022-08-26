package kr.happyjob.study.employee.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.EmppayaccModel;



public interface EmppayaccDao {


	public EmppayaccModel listEmployeeModel(Map<String, Object> paramMap) throws Exception;

	public EmppayaccModel listPayModel(Map<String, Object> paramMap) throws Exception;
}
