package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.SelcomboDao;
import kr.happyjob.study.business.model.selcombo;

@Service
public class SelectComboServiceImpl implements SelectComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SelcomboDao selcomboDao;	
	
	/** 사번 목록 조회 */
	public List<selcombo> selectusercode(Map<String, Object> paramMap) throws Exception {
		
		List<selcombo> listusercode = selcomboDao.selectusercode(paramMap);
		
		return listusercode;	
	};
	
	/** 달성률 목록 조회 */
	public List<selcombo> selectachievementrate(Map<String, Object> paramMap) throws Exception {
		
		List<selcombo> listachievementrate = selcomboDao.selectachievementrate(paramMap);
		
		return listachievementrate;	
	};
			
	/** 부서명 목록 조회 */
	public List<selcombo> selectdeptname(Map<String, Object> paramMap) throws Exception {
		
		List<selcombo> listdeptname = selcomboDao.selectdeptname(paramMap);
		
		return listdeptname;		
	};
			
	/** 사원명 목록 조회 */
	public List<selcombo> selectusername(Map<String, Object> paramMap) throws Exception {
		
		List<selcombo> listusername = selcomboDao.selectusername(paramMap);
		
		return listusername;		
	};
	
}
