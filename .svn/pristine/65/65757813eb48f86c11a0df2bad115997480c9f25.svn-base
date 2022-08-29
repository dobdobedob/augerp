package kr.happyjob.study.sales.controller;

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

import kr.happyjob.study.sales.model.ARMModel;
import kr.happyjob.study.sales.service.ARMService;


@Controller
@RequestMapping("/sales/")
public class ARMController {
	
	@Autowired
	ARMService armService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("ARManagement.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".init");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		return "sales/arManagement";
	}
	
	
	
	
	@RequestMapping("listARM.do")
	public String listaccount(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listarm");
		logger.info(" - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<ARMModel> listARMModel = armService.listARMModel(paramMap);
		
		int totARMModel = armService.totARMModel(paramMap);
		
		model.addAttribute("listARMModel", listARMModel);
		model.addAttribute("totARMModel", totARMModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listarm");
		
		return "sales/arManagementList";
	}	
		
		//2
	@RequestMapping("detailarManagement.do")
	public String detailarManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectarm");
		logger.info("   - paramMap : " + paramMap);
		
		ARMModel armModel = armService.selectarm(paramMap);
		model.addAttribute("armModel",armModel);
		paramMap.put("armModel", armModel);
		
		
		logger.info("+ Stop " + className + ".selectarm");
		
		return "sales/detailarManagement";
		
	}
	
	@RequestMapping("incomeinsert.do")
	@ResponseBody
	public Map<String, Object> incomeinsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".incomeinsert");
		logger.info("   - paramMap 뿌레가ㅣㅓ링넘;: " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		int sqlresult = 0;
		
			sqlresult = armService.incomeinsert(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".incomeinsert");
		
		return returnvalue;
	}	
	
}