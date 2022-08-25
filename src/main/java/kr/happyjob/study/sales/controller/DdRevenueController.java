package kr.happyjob.study.sales.controller;

import java.util.ArrayList;
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

import kr.happyjob.study.sales.service.DdRevenueService;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.system.service.ComnComboService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.sales.model.DdRevenueModel;
import kr.happyjob.study.sales.model.DdRevenueModelChart;

@Controller
@RequestMapping("/sales/")
public class DdRevenueController {

	@Autowired
	DdRevenueService ddRevenueService;
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
		
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("ddRevenue.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//테스트
		System.out.println("처음 로딩 체크");
		
		logger.info("+ Start " + className + ".initDdRevenue");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		//로그인된 아이디 확인
		System.out.println("loginID 는" + loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		
		return "sales/ddRevenue";
	}
	
	// ddRevenueList 불러오기
	@RequestMapping("listDdRevenueModel.do")
	public String listDdRevenue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("list 불러오기 체크");
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		List<DdRevenueModel> listDdRevenueModel = ddRevenueService.listDdRevenueModel(paramMap);
		List<DdRevenueModel> listCopItemOrder = ddRevenueService.listCopItemOrder(paramMap);
		
		//List<ComnCodUtilModel> db = ComnCodUtil.getComnCod("DBCD");
	
	    // 상품 대분류
        //List<comcombo> comComboModel = comnComboService.selectlargelist(paramMap);
		
        //String ldiv = "";
        
        
        
        
		int totDdRevenueModel = ddRevenueService.totDdRevenueModel(paramMap);
		
		model.addAttribute("listDdRevenueModel", listDdRevenueModel);
		model.addAttribute("totDdRevenueModel", totDdRevenueModel);
		model.addAttribute("listCopItemOrder", listCopItemOrder);
		//model.addAttribute("comComboModel", comComboModel);
		
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		for(DdRevenueModel data: listDdRevenueModel){
			System.out.println(data);
		}
		
		return "sales/ddRevenueList";
	}
	
	// ddRevenueList 불러오기
	@RequestMapping("selectlduv.do")
	@ResponseBody
	public Map<String,Object> selectlduv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("list 불러오기 체크");
		
		logger.info("+ Start " + className + ".selectlduv");
		logger.info("   - paramMap : " + paramMap);
		
		List<DdRevenueModelChart> listCopItemOrder = ddRevenueService.listCopItemOrderchart(paramMap);
		
		Map<String,Object> returnval = new HashMap<String,Object>();
		
		returnval.put("listCopItemOrder", listCopItemOrder);
		returnval.put("listCopItemOrdercnt", listCopItemOrder.size());
		
		return returnval;
	}
	
	// CircleGraph 필요값들 DdRevenue 페이지로 주고 받기
	@RequestMapping("CircleGraph.do")
	@ResponseBody
	public String CircleGraph(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("CircleGraph 불러오기 체크");
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		
		
		List<DdRevenueModel> listCircleGraph = ddRevenueService.listCircleGraph(paramMap);
        
		int totCircleGraph = ddRevenueService.totCircleGraph(paramMap);
		
		model.addAttribute("listCircleGraph", listCircleGraph);
		model.addAttribute("totCircleGraph", totCircleGraph);
		
		logger.info("listCircleGraph : " + listCircleGraph);
		logger.info("totCircleGraph : " + totCircleGraph);
		
		for(DdRevenueModel data: listDdRevenueModel){
			System.out.println(data);
		}
		
		return "sales/ddRevenueList";
	}	
	
	
}
