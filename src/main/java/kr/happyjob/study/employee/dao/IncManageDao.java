package kr.happyjob.study.employee.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.employee.model.IncManageModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.employee.model.IncManageModel;

public interface IncManageDao {
	//사원 리스트
	public List<IncManageModel> listIncManageModel(Map<String, Object> paramMap) throws Exception;
	
	public List<IncManageModel> listIncManageiModel(Map<String, Object> paramMap) throws Exception;
	
	
	//사원 리스트 페이지 네비게이션용
	public int totIncManageModel(Map<String, Object> paramMap) throws Exception;
	
	public int totIncManageiModel(Map<String, Object> paramMap) throws Exception;

	
	//사원 개별 조회
	public IncManageModel selectIncManage(Map<String, Object> paramMap) throws Exception;
	//
	public int updateIncManagereadcnt(Map<String, Object> paramMap) throws Exception;

	public int insertIncManage(Map<String, Object> paramMap) throws Exception;
	
	public int updateIncManage(Map<String, Object> paramMap) throws Exception;
	
	public String todayDate(Map<String, Object> paramMap) throws Exception;
	public String todayDD(Map<String, Object> paramMap) throws Exception;
	
	public int saveIncManage(Map<String, Object> paramMap) throws Exception;
	
}
