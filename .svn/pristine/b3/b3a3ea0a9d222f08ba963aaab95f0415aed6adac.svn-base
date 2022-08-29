package kr.happyjob.study.employee.controller;

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

import kr.happyjob.study.employee.model.Department;
import kr.happyjob.study.employee.model.EmpManagement;
import kr.happyjob.study.employee.model.EmpPromotion;
import kr.happyjob.study.employee.service.EmpManagementService;
import kr.happyjob.study.employee.service.EmpPromotionService;

@Controller
@RequestMapping("/employee/")
public class EmpPromotionController {
	
	@Autowired
	EmpManagementService empManagementService;
	
	@Autowired
	EmpPromotionService empPromotionService;
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	//처음 로딩될 때 승진 내역 리스트 페이지 연결 
	@RequestMapping("empPromotion.do")
	public String initempPromotion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".initempPromotion");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		String userNm = (String)session.getAttribute("userNm");
		paramMap.put("loginID", loginID);
		paramMap.put("userNm", userNm);
		System.out.println(loginID);
		
		List<Department> departmentList = empManagementService.departmentList();
		
		//현재 유저의 아이디
		model.addAttribute("loginId",loginID);
		
		//부서 리스트 
		model.addAttribute("departmentList",departmentList);
		
		return "employee/empPromotion";
	}
	
	@RequestMapping("empPromotionList.do")
	public String empPromotionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".empPromotionList");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<EmpPromotion> listEmpPromotionModel = empPromotionService.empPromotionModalList(paramMap);
		
		int totEmpPromotionModel = empPromotionService.totEmpPromotionModel(paramMap);
		
		model.addAttribute("listEmpPromotionModel", listEmpPromotionModel);
		model.addAttribute("totEmpPromotionModel", totEmpPromotionModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".empPromotionList");
		
		return "employee/empPromotionList";
	}	
	
	@RequestMapping("listEmpManagementlogin.do")
	public String listEmpManagementlogin(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEmpManagementlogin");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpagelogin = Integer.parseInt((String) paramMap.get("curpagelogin"));
	    int pageSizelogin = Integer.parseInt((String) paramMap.get("pageSizelogin"));
		int pageIndex = (curpagelogin - 1) * pageSizelogin;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSizelogin);
		
		
		List<EmpPromotion> listEmpPromotionModellogin = empPromotionService.empPromotionModalListlogin(paramMap);
		
		int totEmpPromotionModellogin = empPromotionService.totEmpPromotionModellogin(paramMap);
		
		model.addAttribute("listEmpPromotionModellogin", listEmpPromotionModellogin);
		model.addAttribute("totEmpPromotionModellogin", totEmpPromotionModellogin);
		
		model.addAttribute("curpagelogin", curpagelogin);
		model.addAttribute("pageSizelogin", pageSizelogin);		
		
		logger.info("+ Stop " + className + ".listEmpManagementlogin");
		
		return "employee/empPromotionloginID";
	}	
	
	@RequestMapping("listEmpManagementlogininfo.do")
	@ResponseBody
	public Map<String, Object> listEmpManagementlogininfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEmpManagementlogininfo");
		logger.info("   - paramMap : " + paramMap);
		
		EmpManagement empManagement = empPromotionService.empManagementinfo(paramMap);
		
		Map<String, Object> resultdata = new HashMap<String, Object>();
		
		resultdata.put("empManagement", empManagement);
		
		logger.info("+ Stop " + className + ".listEmpManagementlogininfo");
		
		return resultdata;
	}
}
