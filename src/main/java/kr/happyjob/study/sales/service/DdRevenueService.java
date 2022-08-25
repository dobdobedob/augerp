package kr.happyjob.study.sales.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.DdRevenueModel;
import kr.happyjob.study.sales.model.DdRevenueModelChart;

public interface DdRevenueService {
	
	public List<DdRevenueModel> listDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public int totDdRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public List<DdRevenueModel> listCopItemOrder(Map<String, Object> paramMap) throws Exception;
	
	public List<DdRevenueModelChart> listCopItemOrderchart(Map<String, Object> paramMap) throws Exception;
	
	public List<DdRevenueModel> listCircleGraph(Map<String, Object> paramMap) throws Exception;
	
	public int totCircleGraph(Map<String, Object> paramMap) throws Exception;
	
	public ArrayList<DdRevenueModel> listvkdl (Map<String, Object> paramMap) throws Exception;
	
	
		
}
