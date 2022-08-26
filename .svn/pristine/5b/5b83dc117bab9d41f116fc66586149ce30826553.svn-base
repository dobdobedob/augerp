package kr.happyjob.study.employee.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Date;
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


import kr.happyjob.study.employee.model.IncManageModel;
import kr.happyjob.study.employee.service.IncManageService;

@Controller
@RequestMapping("/employee/")
public class IncManageController {
	
	@Autowired
	IncManageService IncManageService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("IncManage.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initIncManage");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		String loginname = (String) session.getAttribute("userNm");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		String todayDate = IncManageService.todayDate(paramMap);
		String todayDD = IncManageService.todayDD(paramMap);
		
		logger.info("todaydate 는" + todayDate);
		model.addAttribute("loginId", loginID);
		model.addAttribute("loginname", loginname);
		
		model.addAttribute("todayDate", todayDate);
		model.addAttribute("todayDD", todayDD);
		return "employee/IncManage";
	}
	
	
	
	//직원 리스트 검색
	@RequestMapping("listIncManage.do")
	public String listIncManage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listIncManage");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		String todayDate = IncManageService.todayDate(paramMap);
		List<IncManageModel> listIncManageModel = IncManageService.listIncManageModel(paramMap);
		
		int totIncManageModel = IncManageService.totIncManageModel(paramMap);
		
		model.addAttribute("listIncManageModel", listIncManageModel);
		model.addAttribute("totIncManageModel", totIncManageModel);
		
		model.addAttribute("todaydate", todayDate);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("   - 투데이 : " + todayDate);
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		return "employee/IncManageList";
	}	
	@RequestMapping("listIncManagei.do")
	public String listIncManagei(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listIncManage");
		logger.info("   - paramMap : " + paramMap);
		
		
	    int icurpage = Integer.parseInt((String) paramMap.get("icurpage"));
	    int ipageSize = Integer.parseInt((String) paramMap.get("ipageSize"));
		int ipageIndex = (icurpage - 1) * ipageSize;
	 
		
		paramMap.put("ipageIndex", ipageIndex);
		paramMap.put("ipageSize", ipageSize);
		
		String todayDate = IncManageService.todayDate(paramMap);
		List<IncManageModel> listIncManageiModel = IncManageService.listIncManageiModel(paramMap);
		
		int totIncManageiModel = IncManageService.totIncManageiModel(paramMap);
		
		model.addAttribute("listIncManageiModel", listIncManageiModel);
		model.addAttribute("totIncManageiModel", totIncManageiModel);
		
		model.addAttribute("todaydate", todayDate);
		
		model.addAttribute("icurpage", icurpage);
		model.addAttribute("ipageSize", ipageSize);		
		
		
		return "employee/IncManageiList";
	}
	//인센티브 대상자 선택	
	@RequestMapping("selectIncManage.do")
	@ResponseBody
	public Map<String, Object> selectIncManage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectIncManage");
		logger.info("   - paramMap : " + paramMap);
		
		
		
		IncManageModel IncManageModel = IncManageService.selectIncManage(paramMap);
		
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("IncManageModel", IncManageModel);
		returnvalue.put("model", model);
		
		logger.info("+ Stop " + className + ".selectIncManage");
		
		return returnvalue;
	}	
	
	
	//인센티브 저장
	@RequestMapping("saveIncManage.do")
	@ResponseBody
	public Map<String, Object> saveIncManage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		
		logger.info("+ Start " + className + ".saveIncManage");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			sqlresult = IncManageService.insertIncManage(paramMap);
		} else if("U".equals(action)) {  // 수정
			sqlresult = IncManageService.updateIncManage(paramMap);
		} 
		//else if("D".equals(action)) {  // 수정
		//	sqlresult = IncManageService.deleteIncManage(paramMap);
		//}
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".saveIncManage");
		
		return returnvalue;
	}		
}
	