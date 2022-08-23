package kr.happyjob.study.sales.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.DdRevenueModel;
import kr.happyjob.study.sales.model.DdRevenueModelChart;

public interface DdRevenueDao {

	public List<DdRevenueModel> listDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public int totDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public List<DdRevenueModel> listcopItemOrder(Map<String, Object> paramMap) throws Exception;
	
	public List<DdRevenueModelChart> listCopItemOrderchart(Map<String, Object> paramMap) throws Exception;
}
