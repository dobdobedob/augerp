package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.BizPartnerDao;
import kr.happyjob.study.business.model.BizPartnerModel;

@Service
public class BizPartnerServiceImpl implements BizPartnerService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	BizPartnerDao bizPartnerDao;
	
	public int insertBizPartner(Map<String, Object> paramMap) throws Exception{
		
		//전화 번호 수정
		String Tel1 = (String)paramMap.get("Tel1");
		String Tel2 = (String)paramMap.get("Tel2");
		String Tel3 = (String)paramMap.get("Tel3");
		
		String cop_tel = Tel1 + "-" + Tel2 + "-" + Tel3;
		
		String Phone1 = (String)paramMap.get("Phone1");
		String Phone2 = (String)paramMap.get("Phone2");
		String Phone3 = (String)paramMap.get("Phone3");
		
		String cop_phn = Phone1 + "-" + Phone2 + "-" + Phone3;
		
		String ComNo1 = (String)paramMap.get("ComNo1");
		String ComNo2 = (String)paramMap.get("ComNo2");
		String ComNo3 = (String)paramMap.get("ComNo3");
		
		String cop_cno = ComNo1 + "-" + ComNo2 + "-" + ComNo3;
		
		paramMap.put("cop_tel", cop_tel);
		paramMap.put("cop_phn", cop_phn);
		paramMap.put("cop_cno", cop_cno);
		
		int insertBizPartner = bizPartnerDao.insertBizPartner(paramMap);
		return insertBizPartner;
	}

	public List<BizPartnerModel> listBizPartnerModel(Map<String, Object> paramMap) throws Exception {
		
		List<BizPartnerModel> listBizPartnerModel = bizPartnerDao.listBizPartnerModel(paramMap);
		
		return listBizPartnerModel;
	}


	public int totBizPartnerModel(Map<String, Object> paramMap) throws Exception {
		
		int totBizPartnerModel = bizPartnerDao.totBizPartnerModel(paramMap);
		
		return totBizPartnerModel;
	}

	public BizPartnerModel selectBizPartner(Map<String, Object> paramMap) throws Exception {
		
		BizPartnerModel bizPartnerModel = bizPartnerDao.selectBizPartner(paramMap);
		
		return bizPartnerModel;
	}

	
	public int updateBizPartner(Map<String, Object> paramMap) throws Exception {
		
		//전화 번호 수정
		String Tel1 = (String)paramMap.get("Tel1");
		String Tel2 = (String)paramMap.get("Tel2");
		String Tel3 = (String)paramMap.get("Tel3");
		
		String cop_tel = Tel1 + "-" + Tel2 + "-" + Tel3;
		
		String Phone1 = (String)paramMap.get("Phone1");
		String Phone2 = (String)paramMap.get("Phone2");
		String Phone3 = (String)paramMap.get("Phone3");
		
		String cop_phn = Phone1 + "-" + Phone2 + "-" + Phone3;
		
		String ComNo1 = (String)paramMap.get("ComNo1");
		String ComNo2 = (String)paramMap.get("ComNo2");
		String ComNo3 = (String)paramMap.get("ComNo3");
		
		String cop_cno = ComNo1 + "-" + ComNo2 + "-" + ComNo3;
		
		paramMap.put("cop_tel", cop_tel);
		paramMap.put("cop_phn", cop_phn);
		paramMap.put("cop_cno", cop_cno);
		
		logger.info("   - paramMap : " + paramMap);

		return bizPartnerDao.updateBizPartner(paramMap);
	}

	public int deleteBizPartner(Map<String, Object> paramMap) throws Exception {
		
		return bizPartnerDao.deleteBizPartner(paramMap);
	}

}
