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
import kr.happyjob.study.employee.service.EmpManagementService;
import kr.happyjob.study.system.model.NoticeModel;

@Controller
@RequestMapping("/employee/")
public class EmpManagementController {

	@Autowired
	EmpManagementService empManagementService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//처음 로딩될 때 사원 리스트 페이지 연결 
	@RequestMapping("empManagement.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".initempManagement");
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
		
		return "employee/empManagement";
	}
	
	@RequestMapping("listEmpManagement.do")
	public String listEmpManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEmpManagement");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<EmpManagement> listEmpManagementModel = empManagementService.listEmpManagementModel(paramMap);
		
		int totEmpManagementModel = empManagementService.totEmpManagementModel(paramMap);
		
		model.addAttribute("listEmpManagementModel", listEmpManagementModel);
		model.addAttribute("totEmpManagementModel", totEmpManagementModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listEmpManagement");
		
		return "employee/empManagementList";
	}	
	
	@RequestMapping("selectUserRetire.do")
	@ResponseBody
	public Map<String, Object> selectUserRetire(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectUserRetire");
		logger.info("   - paramMap : " + paramMap);
		
		EmpManagement empManagementModel = empManagementService.selectUserRetire(paramMap);
		
		Map<String, Object> resultdata = new HashMap<String, Object>();
		
		resultdata.put("empManagementModel", empManagementModel);
		
		logger.info("+ Stop " + className + ".selectUserRetire");
		
		return resultdata;
	}
	
	@RequestMapping("saveUserRetire.do")
	@ResponseBody
	public Map<String, Object> saveUserRetire(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveUserRetire");
		logger.info("   - paramMap : " + paramMap);
		
		int result =  empManagementService.saveUserRetire(paramMap);
		
		String saveR;
		
		Map<String, Object> savereturn = new HashMap<String, Object>();
		
		if(result <0){
			saveR =  "FAIL";
		}else{
			saveR =  "SUCCESS";
		}
		
		savereturn.put("saveR",saveR);
		
		logger.info("+ Stop " + className + ".saveUserRetire");
		
		return savereturn;
	}
	
	@RequestMapping("saveEmpManagementfile.do")
	@ResponseBody
	public Map<String, Object> saveEmpManagementfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveEmpManagementfile");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
	
        
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			empManagementService.insertEmpManagementfile(paramMap,request);
		} else if("U".equals(action)) {  // 수정
			empManagementService.updateEmpManagementfile(paramMap,request);
		} 
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".saveEmpManagementfile");
		
		return returnvalue;
	}	
	
	@RequestMapping("selectempManagementID.do")
	@ResponseBody
	public Map<String, Object> selectempManagementID(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectempManagementID");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = empManagementService.selectempManagementID();
		
		Map<String, Object> resultdata = new HashMap<String, Object>();
		
		resultdata.put("loginID", loginID);
		
		logger.info("+ Stop " + className + ".selectempManagementID");
		
		return resultdata;
	}
	
	@RequestMapping("selectempManagementInfo.do")
	@ResponseBody
	public Map<String, Object> selectempManagementInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectempManagementInfo");
		logger.info("   - paramMap : " + paramMap);
		
		EmpManagement empManagement = empManagementService.selectempManagementInfo(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("empManagement", empManagement);
		logger.info("select 해온 정보들 " + returnvalue);
		
		logger.info("+ Stop " + className + ".selectempManagementInfo");
		
		return returnvalue;
	}	
	
	
	
}
