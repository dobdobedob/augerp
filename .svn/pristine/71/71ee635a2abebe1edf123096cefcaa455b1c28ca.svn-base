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

import kr.happyjob.study.accounting.model.AccountModel;
import kr.happyjob.study.accounting.service.AccountService;
import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/accounting/")
public class AccountSlipController {
	
	@Autowired
	AccountService accountService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("AccountSlip.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".init");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		return "accounting/accountSlip";
	}
	
	
	
	
	@RequestMapping("listaccount.do")
	public String listaccount(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listaccount");
		logger.info("  리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 리스트 - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<AccountModel> listAccountModel = accountService.listAccountModel(paramMap);
		
		int totAccountModel = accountService.totAccountModel(paramMap);
		
		model.addAttribute("listAccountModel", listAccountModel);
		model.addAttribute("totAccountModel", totAccountModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listaccount");
		
		return "accounting/accountSlipllist";
	}	
		
		
	@RequestMapping("selectaccount.do")
	@ResponseBody
	public Map<String, Object> selectaccount(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectaccount");
		
		AccountModel accountModel = accountService.selectaccount(paramMap);
				   
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("accountModel", accountModel);
		
		logger.info("+ Stop " + className + ".selectaccount");
		
		return returnvalue;
		
	}
	
	@RequestMapping("detailAccount.do")
	public String detailAccount(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("detailAccount.do 실행~~~~~~~~~~~~~~~~~~~~~");
		
		logger.info("+ Start " + className + ".selectaccount");
		logger.info("   - paramMap : " + paramMap);
		
		
		paramMap.put("pageIndex", 0);
		paramMap.put("pageSize", 999999999);
		
		List<AccountModel> listAccountModel = accountService.listAccountModel(paramMap);
		
		AccountModel accountModel = accountService.selectcopinfo(paramMap);
		
		model.addAttribute("listAccountModel",listAccountModel);
		model.addAttribute("accountModel",accountModel);
		
		
		logger.info("+ Stop " + className + ".selectaccount");
		
		return "accounting/accountSlipllist2";
		
	}
}