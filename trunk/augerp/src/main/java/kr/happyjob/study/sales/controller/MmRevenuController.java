package kr.happyjob.study.sales.controller;

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

import kr.happyjob.study.sales.model.MmRevenueModel;
import kr.happyjob.study.sales.service.MmRevenueService;
import kr.happyjob.study.system.service.ComnComboService;

@Controller
@RequestMapping("/sales/")
public class MmRevenuController {

	@Autowired
	MmRevenueService mmRevenueService;
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("mmRevenue.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//테스트
		System.out.println("처음 로딩 체크");
		
		logger.info("+ Start " + className + ".initMmRevenue");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		//로그인된 아이디 확인
		System.out.println("loginID 는" + loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		
		return "sales/mmRevenue";
	}
	
	// mmRevenueList 불러오기
	@RequestMapping("listMmRevenueModel.do")
	public String listMmRevenue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("list 불러오기 체크");
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<MmRevenueModel> listMmRevenueModel = mmRevenueService.listMmRevenueModel(paramMap);
		
		int totMmRevenueModel = mmRevenueService.totMmRevenueModel(paramMap);
		
		model.addAttribute("listMmRevenueModel", listMmRevenueModel);
		model.addAttribute("totMmRevenueModel", totMmRevenueModel);
		
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		for(MmRevenueModel data: listMmRevenueModel){
			System.out.println(data);
		}
		
		return "sales/mmRevenueList";
	}	
	
	
}
