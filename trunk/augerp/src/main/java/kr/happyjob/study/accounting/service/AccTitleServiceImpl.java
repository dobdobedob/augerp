package kr.happyjob.study.accounting.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.accounting.dao.AccTitleDao;
import kr.happyjob.study.accounting.model.AccTitleModel;


@Service
public class AccTitleServiceImpl implements AccTitleService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AccTitleDao AccTitleDao;
	
	
	public List<AccTitleModel> listAccTitleModel(Map<String, Object> paramMap) throws Exception {
		
		List<AccTitleModel> listAccTitleModel = AccTitleDao.listAccTitleModel(paramMap);
		
		return listAccTitleModel;
	}
	
	public int totAccTitleModel(Map<String, Object> paramMap) throws Exception {
		
		int totAccTitleModel = AccTitleDao.totAccTitleModel(paramMap);
		
		return totAccTitleModel;
	}	
	
    public AccTitleModel selectAccTitle(Map<String, Object> paramMap) throws Exception {
		
		AccTitleModel AccTitleModel = AccTitleDao.selectAccTitle(paramMap);
		
		return AccTitleModel;
	}
	
    
    public int updateAccTitlereadcnt(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.updateAccTitlereadcnt(paramMap);
	}
    
 /*
    public int insertAccTitle(Map<String, Object> paramMap) throws Exception {
		
		return AccTitleDao.insertAccTitle(paramMap);
	}
   
    */
    public int updateAccTitle(Map<String, Object> paramMap) throws Exception {
    	
    	String acc_nm = (String)paramMap.get("acc_nm");
    	String acc_nm_ori = (String)paramMap.get("acc_nm_ori");
    	
    	if(!acc_nm.equals(acc_nm_ori)){//대분류 명이 변경되었을 시에 탄다
    		int changeB = AccTitleDao.changeB(paramMap);
    	}
    	
		int updateAccTitle = AccTitleDao.updateAccTitle(paramMap);//계정 소분류 업데이트
		return updateAccTitle;
	}

	
	public int insertdtlAccTitle(Map<String, Object> paramMap) throws Exception {

		return AccTitleDao.insertdtlAccTitle(paramMap);
	}
    
    
    
}
