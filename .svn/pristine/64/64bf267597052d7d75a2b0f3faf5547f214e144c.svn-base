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

import kr.happyjob.study.employee.model.EmppayaccModel;
import kr.happyjob.study.employee.service.EmppayaccService;


@Controller
@RequestMapping("/employee/")
public class EmppayaccController {
	
	@Autowired
	EmppayaccService emppayaccService;

	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("empPayAcc.do")
	public String empPayHist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".empPayAcc");
		logger.info("  첫로딩 - paramMap : " + paramMap);
		
		
		String loginID = (String) session.getAttribute("loginId");  //loginController 에서 loginId로함
		model.addAttribute("loginId", loginID);
		paramMap.put("loginID", loginID);
		//mapper랑 글자 동일하게 해야한다 "loginID"

		
		logger.info("   - paramMap : " + paramMap);

		//vo 변수 = 서비스 . 던질 이름 (paramMap);
		EmppayaccModel deptList = emppayaccService.listEmployeeModel(paramMap);
		model.addAttribute("deptList", deptList);
		paramMap.put("deptList", deptList);
		//mapper랑 글자 동일하게 해야한다 "deptList"
		logger.info("===========================================================");
		logger.info(paramMap);
		logger.info("===========================================================");
		logger.info(deptList);
		logger.info("===========================================================");

		//한개list는 ${list.writer} 의 list다 
		
		EmppayaccModel payList = emppayaccService.listPayModel(paramMap);
		model.addAttribute("payList",payList);
		paramMap.put("payList", payList);
		
		logger.info("===========================================================");
		logger.info(payList);
		logger.info("===========================================================");
		
		logger.info("+ end " + className + ".empPayAcc");
		
		return "employee/empPayAcc";
	}
	
	@RequestMapping("empPayAccreseach.do")
	@ResponseBody
	public Map<String, Object> empPayAccreseach(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".empPayAcc");
		logger.info("  첫로딩 - paramMap : " + paramMap);
		
		
		String loginID = (String) session.getAttribute("loginId");  //loginController 에서 loginId로함
		model.addAttribute("loginId", loginID);
		paramMap.put("loginID", loginID);
		//mapper랑 글자 동일하게 해야한다 "loginID"

		
		

		//vo 변수 = 서비스 . 던질 이름 (paramMap);
		EmppayaccModel deptList = emppayaccService.listEmployeeModel(paramMap);
		model.addAttribute("deptList", deptList);
		paramMap.put("deptList", deptList);
		//mapper랑 글자 동일하게 해야한다 "deptList"

		//한개list는 ${list.writer} 의 list다 
		
		EmppayaccModel payList = emppayaccService.listPayModel(paramMap);
		model.addAttribute("payList",payList);
		paramMap.put("payList", payList);
		
		logger.info("2222222222222222222222222222222222222222222222222222222");
		logger.info(payList);
		logger.info("2222222222222222222222222222222222222222222222222222222");
		
		Map<String, Object> resultdata = new HashMap<String, Object>();
		resultdata.put("payList",payList);
		
		logger.info("+ end " + className + ".empPayAcc");
		
		return resultdata;
	}
}