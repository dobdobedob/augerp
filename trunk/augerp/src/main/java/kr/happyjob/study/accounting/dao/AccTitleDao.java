package kr.happyjob.study.accounting.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accounting.model.AccTitleModel;

public interface AccTitleDao {

	public List<AccTitleModel> listAccTitleModel(Map<String, Object> paramMap) throws Exception;

	public int totAccTitleModel(Map<String, Object> paramMap) throws Exception;
	
	public AccTitleModel selectAccTitle(Map<String, Object> paramMap) throws Exception;

	public int updateAccTitlereadcnt(Map<String, Object> paramMap) throws Exception;

//	public int insertAccTitle(Map<String, Object> paramMap) throws Exception;
	
	public int insertdtlAccTitle(Map<String, Object> paramMap) throws Exception;
	
	public int updateAccTitle(Map<String, Object> paramMap) throws Exception;

	public int changeB(Map<String, Object> paramMap) throws Exception;

	
	
}
