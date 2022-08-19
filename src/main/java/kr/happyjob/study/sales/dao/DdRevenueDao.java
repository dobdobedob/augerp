package kr.happyjob.study.sales.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.DdRevenueModel;

public interface DdRevenueDao {

	public List<DdRevenueModel> listDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public int totDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
}
