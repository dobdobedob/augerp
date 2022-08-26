package kr.happyjob.study.business.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.selcombo;

public interface SelcomboDao {

	
	/** 사번 목록 조회 */
	public List<selcombo> selectusercode(Map<String, Object> paramMap) throws Exception;
	
	/** 달성률 목록 조회 */
	public List<selcombo> selectachievementrate(Map<String, Object> paramMap) throws Exception;
			
	/** 부서명 목록 조회 */
	public List<selcombo> selectdeptname(Map<String, Object> paramMap) throws Exception;
			
	/** 사원명 목록 조회 */
	public List<selcombo> selectusername(Map<String, Object> paramMap) throws Exception;
			

}
