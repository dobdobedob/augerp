package kr.happyjob.study.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.model.BizPartnerModel;
import kr.happyjob.study.business.service.BizPartnerService;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.NoticeModel;

@Controller
@RequestMapping("/business/")
public class BizPartnerController {
	
	@Autowired
	BizPartnerService bizPartnerService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	

	//처음 로딩될 때 거래처 리스트 페이지 연결 
	@RequestMapping("bizPartner.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".initBizPartner");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		String userNm = (String)session.getAttribute("userNm");
		paramMap.put("loginID", loginID);
		paramMap.put("userNm", userNm);
		System.out.println(loginID);
		

		//현재 유저의 아이디
		model.addAttribute("loginId",loginID);
		
		return "business/partner";
	}
	
	@RequestMapping("listBizPartner.do")
	public String listBizPartner(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listBizPartner");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<BizPartnerModel> listBizPartnerModel = bizPartnerService.listBizPartnerModel(paramMap);
		
		int totBizPartnerModel = bizPartnerService.totBizPartnerModel(paramMap);
		
		model.addAttribute("listBizPartnerModel", listBizPartnerModel);
		model.addAttribute("totBizPartnerModel", totBizPartnerModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listBizPartner");
		
		return "business/partnerList";
	}	
	
	@RequestMapping("selectBizPartner.do")
	@ResponseBody
	public Map<String, Object> selectBizPartner(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectBizPartner");
		logger.info("   - paramMap : " + paramMap);
		
		BizPartnerModel BizPartnerModel = bizPartnerService.selectBizPartner(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("BizPartnerModel", BizPartnerModel);
		
		logger.info("+ Stop " + className + ".selectBizPartner");
		
		return returnvalue;
	}	
	
	
	@RequestMapping("saveBizPartner.do")
	@ResponseBody
	public Map<String, Object> saveBizPartner(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savenotice");
		logger.info("   - paramMap : " + paramMap);
		
		
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			sqlresult = bizPartnerService.insertBizPartner(paramMap);
		} else if("U".equals(action)) {  // 수정
			sqlresult = bizPartnerService.updateBizPartner(paramMap);
		} else if("D".equals(action)) {  // 수정
			sqlresult = bizPartnerService.deleteBizPartner(paramMap);
		}
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".saveBizPartner");
		
		return returnvalue;
	}		
}
