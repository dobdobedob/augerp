package kr.happyjob.study.accounting.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.happyjob.study.accounting.model.AccTitleModel;
import kr.happyjob.study.accounting.service.AccTitleService;

@Controller     
@RequestMapping("/accounting/")
public class AccTitleController {
	
	@Autowired
	AccTitleService AccTitleService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("AccTitle.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		return "accounting/acctitle";
	}
	
	
	
	
	@RequestMapping("listAccTitle.do")
	public String listAccTitleModel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listAccTitle");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<AccTitleModel> listAccTitleModel = AccTitleService.listAccTitleModel(paramMap);
		
		int totAccTitleModel = AccTitleService.totAccTitleModel(paramMap);
		
		model.addAttribute("listAccTitleModel", listAccTitleModel);
		model.addAttribute("totAccTitleModel", totAccTitleModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listAccTitle");
		
		return "accounting/acctitleList";
	}	
		
		
	@RequestMapping("selectAccTitle.do")
	@ResponseBody
	public Map<String, Object> selectAccTitle(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		AccTitleModel AccTitleModel = AccTitleService.selectAccTitle(paramMap);
				
		//AccTitleService.updateAccTitlereadcnt(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("AccTitleModel", AccTitleModel);
		
		logger.info("+ Stop " + className + ".selectAccTitle");
		
		return returnvalue;
	}	
	
	
	
	@RequestMapping("saveAccTitle.do")
	@ResponseBody
	public Map<String, Object> saveAccTitle(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveAccTitle");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("U".equals(action)) {  // 수정
			sqlresult = AccTitleService.updateAccTitle(paramMap);
			
		}else if("I".equals(action)){
			sqlresult = AccTitleService.insertdtlAccTitle(paramMap);
		}
		/*
		if("I".equals(action)) { // 등록
			
		} else if("U".equals(action)) {  // 수정
			
		}
		*/
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".saveAccTitle");
		
		return returnvalue;
	}		
	
}
