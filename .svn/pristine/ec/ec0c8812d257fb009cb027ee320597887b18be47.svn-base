package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.ComnComboDao;
import kr.happyjob.study.system.model.comcombo;

@Service
public class ComnComboServiceImpl implements ComnComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ComnComboDao comnComboDao;	
	
	/** 부서 목록 조회 */
	public List<comcombo> selectdeptlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> listdept = comnComboDao.selectdeptlist(paramMap);
		
		return listdept;
	}
	
	/** 계정 목록 조회 */
	public List<comcombo> selectacclargelist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> acclist = comnComboDao.selectacclargelist(paramMap);
		
		return acclist;
	}
	
	/** 상세 계정 목록 조회 */
	public List<comcombo> selectaccsamalllist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> acclist = comnComboDao.selectaccsamalllist(paramMap);
		
		return acclist;
	}
		
	/** 거래처 목록 조회 */
	public List<comcombo> selectclientlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectclientlist(paramMap);
		
		return list;
	}
	
	/** 상품 목록 조회 */
	public List<comcombo> selectproductlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectproductlist(paramMap);
		
		return list;
	}	

	
	/** 제품 대분류 목록 조회 */
	public List<comcombo> selectlargelist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectlargelist(paramMap);
		
		return list;
	}
		
	/** 제품 중분류 목록 조회 */
	public List<comcombo> selectmidlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectmidlist(paramMap);
		
		return list;
	}
		
	/** 제품 대분류,중분류 별  목록 조회 */
	public List<comcombo> selectdivproductlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectdivproductlist(paramMap);
		
		return list;
	}
			
	
}
