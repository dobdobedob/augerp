package kr.happyjob.study.sales.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.ARMModel;

public interface ARMDao {

	public List<ARMModel> listARMModel(Map<String, Object> paramMap) throws Exception;

	public int totARMModel(Map<String, Object> paramMap) throws Exception;
	
	public ARMModel selectarm(Map<String, Object> paramMap) throws Exception;

	public int incomeinsert(Map<String, Object> paramMap)throws Exception;
	

	
}