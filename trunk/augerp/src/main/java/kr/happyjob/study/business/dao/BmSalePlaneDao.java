package kr.happyjob.study.business.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.BmSalePlanModel;

public interface BmSalePlaneDao {
	// 
	public List<BmSalePlanModel> listBmSalePlaneModel(Map<String, Object> paramMap) throws Exception;
	
	public int totBmSalePlanModel(Map<String, Object> paramMap) throws Exception;
	
/*	아래 단건조회 수정후 업데이트 이런거 다 필요 없다
	public NoticeModel selectnotice(Map<String, Object> paramMap) throws Exception;

	public int updatenoticereadcnt(Map<String, Object> paramMap) throws Exception;

	public int insertnotice(Map<String, Object> paramMap) throws Exception;
	
	public int updatenotice(Map<String, Object> paramMap) throws Exception;

	public int deletenotice(Map<String, Object> paramMap) throws Exception;

	public int insertnoticefile(Map<String, Object> paramMap) throws Exception;

	public int noticefiledelete(Map<String, Object> paramMap) throws Exception;
	
	public int notefileinit(Map<String, Object> paramMap) throws Exception;
	
	public int updatefilenotice(Map<String, Object> paramMap) throws Exception;
*/
}
