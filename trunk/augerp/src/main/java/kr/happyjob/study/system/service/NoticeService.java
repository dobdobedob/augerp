package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeService {

	public List<NoticeModel> listNoticeModel(Map<String, Object> paramMap) throws Exception;

	public int totNoticeModel(Map<String, Object> paramMap) throws Exception;
	
	public NoticeModel selectnotice(Map<String, Object> paramMap) throws Exception;
	
	public int updatenoticereadcnt(Map<String, Object> paramMap) throws Exception;
	
	public int insertnotice(Map<String, Object> paramMap) throws Exception;
	
	public int updatenotice(Map<String, Object> paramMap) throws Exception;
	
	public int deletenotice(Map<String, Object> paramMap) throws Exception;

	public void insertnoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	public void updatenoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	public void deletenoticefile(Map<String, Object> paramMap) throws Exception;


}
