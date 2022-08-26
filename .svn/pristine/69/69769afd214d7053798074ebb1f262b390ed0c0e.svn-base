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

import kr.happyjob.study.business.model.EstmanagementModel;
import kr.happyjob.study.business.service.EstmanagementService;

@Controller
@RequestMapping("/business/")
public class EstmanagementController {
	
	@Autowired
	EstmanagementService estmanagementService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 메인페이지 연결
	@RequestMapping("estManagement.do")
	public String business(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".business");
		logger.info(" 첫로딩연결 - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		logger.info("+ Stop " + className + ".business");
		
		return "business/estManagement";
	}
	
	
	
	//메인리스트
	@RequestMapping("estManagementlist.do")
	public String listestmanagementCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listestmanagementCod");
		logger.info(" 리스트  - paramMap : " + paramMap);
		

		int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<EstmanagementModel> listEstmanagementModel = estmanagementService.listEstmanagementModel(paramMap);
		
		int totEstmanagementModel = estmanagementService.totEstmanagementModel(paramMap);
		
		model.addAttribute("listEstmanagementModel", listEstmanagementModel);
		model.addAttribute("totEstmanagementModel", totEstmanagementModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listestmanagementCod");
		
		return "business/estManagementList";
	}
	
	//견적서상세조회
	@RequestMapping("selectestmanagement.do")
	public String selectestmanagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectestmanagement");
		logger.info("   - paramMap : " + paramMap);
		
		List<EstmanagementModel> selectestmanagement = estmanagementService.selectestmanagement(paramMap);
				
		
		EstmanagementModel cardTot = estmanagementService.listcardTot(paramMap);
		model.addAttribute("cardTot",cardTot);
		paramMap.put("cardTot", cardTot);

		
		
		model.addAttribute("selectestmanagement", selectestmanagement);
	    
		
		logger.info("+ Stop " + className + ".selectestmanagement");
		
		return "business/estManagementselectList";
	}		
	
	//견적서등록 모달
	@RequestMapping("estManagementinsert.do")
	public String estManagementinsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".estManagementinsert");
		logger.info("  paramMap : " + paramMap);

		
		List<EstmanagementModel> estimatelist = estmanagementService.estimatelist(paramMap);
		model.addAttribute("estimatelist",estimatelist);

		
		logger.info("+ ================================================================== " + className + ".estManagementinsert");

		logger.info("+ Stop " + className + ".estManagementinsert");
		
		return "business/estManagementinsert";
		
	}
	
	

	@RequestMapping("saveEmti.do")
	@ResponseBody
	public Map<String, Object> saveEmti(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveEmt");
		logger.info("   - paramMap : " + paramMap);
		
		
		int sqlresult = 0;
		
		sqlresult = estmanagementService.saveEmti(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("sqlresult", "");
		} else {
			returnvalue.put("sqlresult", sqlresult);
		}
		
		logger.info("+ Stop " + className + ".saveEmt");
		
		return returnvalue;

	}	
	
	@RequestMapping("selectEstNo.do")
	public String selectEstNo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectEstNo");
		logger.info("  paramMap : " + paramMap);

		
		List<EstmanagementModel> selectEstNo = estmanagementService.selectEstNo(paramMap);
		model.addAttribute("selectEstNo",selectEstNo);

		


		logger.info("+ Stop " + className + ".selectEstNo");
		
		return "business/listEm";
		
	}

	@RequestMapping("deleteEmti.do")
	@ResponseBody
	public Map<String, Object> deleteEmti(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".=deleteEmti");
		logger.info("  paramMap : " + paramMap);
		logger.info("  ========================================================================================");

	
		
		int sqlresultd = 0;

			sqlresultd = estmanagementService.deleteEmti(paramMap);
		
		
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		

		returnvalue.put("sqlresultd", sqlresultd);
		
		logger.info("  ========================================================================================");
		logger.info("+ Stop " + className + "deleteEmti");
		
		return returnvalue;

	}	
		
		
}
