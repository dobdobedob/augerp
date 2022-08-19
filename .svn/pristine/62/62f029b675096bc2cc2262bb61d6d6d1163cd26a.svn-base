package kr.happyjob.study.business.controller;

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

import kr.happyjob.study.business.model.BmSalePlanModel;
import kr.happyjob.study.business.service.BmSalePlanService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;

@Controller
@RequestMapping("/business/")
public class BmSalePlanController {

	@Autowired
	BmSalePlanService bmsaleplanService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 처음 로딩될 때 영업 실적 조회 연결
	@RequestMapping("bmSalePlan.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		//테스트
		System.out.println("처음 로딩 체크");
		
		logger.info("+ Start " + className + ".initNotice");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		String pln_ddate = (String) session.getAttribute("pln_ddate");
		paramMap.put("pln_ddate", pln_ddate);
		
		//로그인된 아이디 확인
		System.out.println("loginID 는" + loginID);
		
		System.out.println("pln_ddate 는" + pln_ddate + "너 왜 null 이야 빨리 나오라고 데이터 나오라고오오");
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		return "business/bmSalePlan";
	}	
	
	// bmSalePlanList 불러오기
	@RequestMapping("listBmSalePlaneModel.do")
	public String listbmsaleplan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		System.out.println("list 불러오기 체크");
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<BmSalePlanModel> listBmSalePlaneModel = bmsaleplanService.listBmSalePlaneModel(paramMap);
		
		int totBmSalePlanModel = bmsaleplanService.totBmSalePlanModel(paramMap);
		
		model.addAttribute("listBmSalePlaneModel", listBmSalePlaneModel);
		model.addAttribute("totBmSalePlanModel", totBmSalePlanModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		for(BmSalePlanModel data: listBmSalePlaneModel){
			System.out.println(data);
		}
		
		return "business/bmSalePlanList";
	}
	
	/**
	 * 콤보박스 만들고싶었어요 근데 group_code 쪽으로 어떻게 가는지 모르겠어서 닫았습니다.
	@RequestMapping(value="/sitemcombo.do")
	@ResponseBody
	public  Map<String,Object> sitemcombo(Model model, 
			@RequestParam Map<String, Object> paramMap, 
			HttpServletRequest request,
			HttpServletResponse response, 
			HttpSession session) throws Exception {
	
		System.out.println("sitemcombo 작동함 !!!");
		
		logger.info("+ Start " + className );
		logger.info("   - paramMap : " + paramMap);
		
		String groupcode = (String) paramMap.get("group_code");
		
		List<ComnCodUtilModel> list = ComnCodUtil.getComnCod(groupcode);	// 공유대상구분코드 (M제외)
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", list);
		
		logger.info("+ End " + className + " : " + list.size());
		 
		return resultMap;
	} */
		
}
