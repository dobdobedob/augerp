package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.MmRevenueModel;

public interface MmRevenueService {

	public List<MmRevenueModel> listMmRevenueModel(Map<String, Object> paramMap) throws Exception;
	
	public int totMmRevenueModel(Map<String, Object> paramMap) throws Exception;	
}
