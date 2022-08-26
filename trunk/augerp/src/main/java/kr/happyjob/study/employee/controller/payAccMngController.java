package kr.happyjob.study.employee.controller;

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


import kr.happyjob.study.employee.model.payAccMngModel;
import kr.happyjob.study.employee.service.payAccMngService;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
@RequestMapping("/employee/")
public class payAccMngController {
	
	@Autowired
	payAccMngService payAccMngService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 급여관리 연결
	@RequestMapping("payAccMng.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initpayAccMng");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
		model.addAttribute("loginId", loginID);
		
		return "employee/payAccMng";
	}
	
	//사원정보리스트 가져오기
	@RequestMapping("listpayAccMng.do")
	public String listComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listpayAccMng");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<payAccMngModel> listpayAccMngModel = payAccMngService.listpayAccMngModel(paramMap);
		
		int totpayAccMngModel = payAccMngService.totpayAccMngModel(paramMap);
		
		model.addAttribute("listpayAccMngModel", listpayAccMngModel);
		model.addAttribute("totpayAccMngModel", totpayAccMngModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		return "employee/payAccMngList";
	}	
	
	//지급내역리스트 가져오기
		@RequestMapping("listpaydtlAccMng.do")
		public String listpaydtlAccMng(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".listpayAccMng");
			logger.info("   - paramMap : " + paramMap);
			

		    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
		    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
			int pageIndex = (curpage - 1) * pageSize;
		    
			paramMap.put("pageIndex", pageIndex);
			paramMap.put("pageSize", pageSize);
			
			
			List<payAccMngModel> listpaydtlAccMngModel = payAccMngService.listpayAccMngModel(paramMap);
			
			int totpayAccMngModel = payAccMngService.totpayAccMngModel(paramMap);
			
			model.addAttribute("listpayAccMngModel", listpaydtlAccMngModel);
			model.addAttribute("totpayAccMngModel", totpayAccMngModel);
			
			model.addAttribute("curpage", curpage);
			model.addAttribute("pageSize", pageSize);		
			
			logger.info("+ Stop " + className + ".listComnGrpCod");
			
			return "employee/payAccMngDtlList";
		}	
	
	
	@RequestMapping("selectpayAccMng.do")
	@ResponseBody
	public Map<String, Object> selectpayAccMng(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectpayAccMng");
		logger.info("   - paramMap : " + paramMap);
		
		payAccMngModel payAccMngModel = payAccMngService.selectpayAccMng(paramMap);
				
		payAccMngService.updatepayAccMngreadcnt(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("payAccMngModel", payAccMngModel);
		
		logger.info("+ Stop " + className + ".selectpayAccMng");
		
		return returnvalue;
	}	
	
	
	//모달창 확인버튼
	/*
	@RequestMapping("confirmpayAccMng.do")
	@ResponseBody
	public Map<String, Object> confirmpayAccMng(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".confirmpayAccMng");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			sqlresult = payAccMngService.insertpayAccMng(paramMap);
		} else if("U".equals(action)) {  // 수정
			sqlresult = payAccMngService.updatepayAccMng(paramMap);
		} else if("D".equals(action)) {  // 삭제
			sqlresult = payAccMngService.deletepayAccMng(paramMap);
		}
		
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".confirmpayAccMng");
		
		return returnvalue;
	}		
	
	*/
	/**
	 * 지급내역 목록
	 */
	@RequestMapping("payAccMngDtlList.do")
	public String payAccMngDtlList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".payAccMngDtlList");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("curpagedtl"));	// 현재 페이지 번호
		int pageSizedtl = Integer.parseInt((String)paramMap.get("dtlpageSize"));			// 페이지 사이즈
		int pageIndexdtl = (currentPage-1)*pageSizedtl;									// 페이지 시작 row 번호
		

		paramMap.put("pageIndexdtl", pageIndexdtl);
		paramMap.put("pageSizedtl", pageSizedtl);
		
		// 지급내역 목록 조회
		List<payAccMngModel> listpayAccMngModel = payAccMngService.listpayAccMngModeldtl(paramMap);
		model.addAttribute("listpayAccMngModeldtl", listpayAccMngModel);
		
		// 지급내역 목록 카운트 조회
		int totalCount = payAccMngService.countListComnDtlCoddtl(paramMap);
		model.addAttribute("totpayAccMngModeldtl", totalCount);
		
		model.addAttribute("pageSizedtl", pageSizedtl);
		model.addAttribute("currentPagedtl",currentPage);
		
		logger.info("+ End " + className + ".payAccMngDtlList");

		return "/employee/payAccMngDtlList";
	}	
}
