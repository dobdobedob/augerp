package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.EstmanagementModel;


public interface EstmanagementService {
	
	public List<EstmanagementModel> listEstmanagementModel(Map<String, Object> paramMap) throws Exception;
	
	public int totEstmanagementModel(Map<String, Object> paramMap) throws Exception;

	public List<EstmanagementModel> selectestmanagement(Map<String, Object> paramMap) throws Exception;

	public EstmanagementModel listcardTot(Map<String, Object> paramMap) throws Exception;
	
	public List<EstmanagementModel> estimatelist(Map<String, Object> paramMap) throws Exception;

	public int saveEmti(Map<String, Object> paramMap) throws Exception;
	
	public List<EstmanagementModel> selectEstNo(Map<String, Object> paramMap) throws Exception;
	
	public int deleteEmti(Map<String, Object> paramMap) throws Exception;
	
	
	
	
}
