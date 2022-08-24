package kr.happyjob.study.business.controller;

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

import kr.happyjob.study.business.model.BmSalePlanModel;
import kr.happyjob.study.business.model.selcombo;
import kr.happyjob.study.business.service.BmSalePlanService;
import kr.happyjob.study.business.service.SelectComboService;

@Controller
@RequestMapping("/business/")
public class BmSalePlanController {

	@Autowired
	BmSalePlanService bmsaleplanService;
	
	@Autowired
	SelectComboService selectComboService;
	
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
	 *  선택 콤보
	 */
	@RequestMapping("selectCombo.do")
	@ResponseBody
	public Map<String, Object> selectCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectCombo");
		logger.info("   - paramMap : " + paramMap);

		String Selecttype = (String) paramMap.get("selecttype");
			
		List<selcombo> comComboModel = new ArrayList<>();
		
		logger.info("   - Selecttype : " + Selecttype);
		
		if("s".equals(Selecttype)) {
			// 사번
			comComboModel = selectComboService.selectusercode(paramMap);
		} else if("a".equals(Selecttype)) {
			// 달성률
			comComboModel = selectComboService.selectachievementrate(paramMap);
		} else if("d".equals(Selecttype)) {
			// 부서명
			comComboModel = selectComboService.selectdeptname(paramMap);
		} else if("u".equals(Selecttype)) {
			// 사원명
			comComboModel = selectComboService.selectusername(paramMap);
		}
		//사번, 달성률(입력 값 이상), 부서명, 사원명
		//usercode, achievementrate, deptname, username
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		
		logger.info("+ End " + className + ".productCombo");
		
		return resultMap;
	}	
	
}