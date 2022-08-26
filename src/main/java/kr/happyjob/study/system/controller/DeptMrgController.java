package kr.happyjob.study.system.controller;

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

import kr.happyjob.study.system.model.DeptMrgModel;
import kr.happyjob.study.system.service.DeptMrgService;

@Controller
@RequestMapping("/system/")
public class DeptMrgController {
	
	@Autowired
	DeptMrgService DeptMrgService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("deptManagement.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initDeptMrg");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
		model.addAttribute("loginId", loginID);
		
		return "system/deptMrg";
	}
	
	
	
	
	//@RequestMapping("listDeptMrg.do")
	@RequestMapping("deptMrg.do")
	public String listDeptMrgModel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listDeptMrg");
		logger.info("   - paramMap : " + paramMap);
		
	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<DeptMrgModel> listdeptMrgModel = DeptMrgService.listDeptMrgModel(paramMap);
		
		int totdeptMrgModel = DeptMrgService.totdeptMngModel(paramMap);
		
		model.addAttribute("listdeptMrgModel", listdeptMrgModel);
		model.addAttribute("totdeptMrgModel", totdeptMrgModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		return "system/deptMrgList";
	}	
		
		
	@RequestMapping("selectDeptMrg.do")
	@ResponseBody
	public Map<String, Object> selectDeptMrg(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectDeptMrg");
		logger.info("   - paramMap : " + paramMap);
		
		DeptMrgModel DeptMrgModel = DeptMrgService.selectDeptMrg(paramMap);
				
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
	
		returnvalue.put("DeptMrgModel", DeptMrgModel);
		
		logger.info("+ Stop " + className + ".selectDeptMrg");
		
		return returnvalue;
	}	
	
	
	
	@RequestMapping("saveDeptMrg.do")
	@ResponseBody
	public Map<String, Object> saveDeptMrg(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveDeptMrg");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			sqlresult = DeptMrgService.insertDeptMrg(paramMap);
		} else if("U".equals(action)) {  // 수정
			sqlresult = DeptMrgService.updateDeptMrg(paramMap);
		} else if("D".equals(action)) {  // 삭제
			sqlresult = DeptMrgService.deleteDeptMrg(paramMap);
		}
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".saveDeptMrg");
		
		return returnvalue;
	}		
	
		
}
