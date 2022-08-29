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

import kr.happyjob.study.business.model.OeManagementDtlListModel;
import kr.happyjob.study.business.model.OeManagementDtlModel;
import kr.happyjob.study.business.model.OeManagementModel;
import kr.happyjob.study.business.model.OeModalModel;
import kr.happyjob.study.business.service.OeManagementService;

@Controller
@RequestMapping("/business/")
public class OeManagementController {
	
	@Autowired
	OeManagementService oeManagementService; 
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 수주 관리 초기화면
	 */
	@RequestMapping("oeManagement.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".onManagement");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".onManagement");

		return "business/oeManagement";
	}
	
	
	/**
	 * 수주관리 목록 조회
	 */
	@RequestMapping("listOeManagement.do")
	public String listOeManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listOeManagement");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<OeManagementModel> listOeManagementModel = oeManagementService.listOeManagement(paramMap);
		model.addAttribute("listOeManagement", listOeManagementModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = oeManagementService.countListOeManagement(paramMap);
		
		model.addAttribute("totalCntOeManagement", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageOeManagement",currentPage);
		
		logger.info("+ End " + className + ".listOeManagement");
		

		return "/business/oeManagementList";
	}	
	
	/**
	 * 수주관리 모달창 정보 목록 조회
	 */
	@RequestMapping("DtlOeManagement.do")
	public String DtlOeManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".DtlOeManagement");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;	
		
		System.out.println("DtlOeManagement currentPage"+currentPage);
		System.out.println("DtlOeManagement pageSize"+pageSize);
		System.out.println("DtlOeManagement pageIndex"+pageIndex);
	
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		//로그인 한 사람 정보 가져올때 사용 
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		System.out.println("DtlOeManagement paramMap:::::::::::::::"+paramMap);
		
		// 수주관리 목록 조회
		OeManagementDtlModel DtlOeManagementModel = oeManagementService.DtlOeManagement(paramMap);
		List<OeManagementDtlListModel> oeDtlListCodModel = oeManagementService.DtlListOeManagement(paramMap); 
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = oeManagementService.selectListTotalModal(paramMap);
		
		System.out.println("OeManagemnetController DtlOeManagement DtlOeManagementModel"+DtlOeManagementModel);
		System.out.println("OeManagemnetController oeDtlListCodModel"+oeDtlListCodModel);
		System.out.println("OeManagemnetController totalCount"+totalCount);
		
		model.addAttribute("totalCntModalOeManagement", totalCount);
		model.addAttribute("DtlListInfo", DtlOeManagementModel);
		model.addAttribute("DtlListModal", oeDtlListCodModel);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("curPageOeManagement",currentPage);
		
		logger.info("+ End " + className + ".DtlOeManagement");
		

		return "/business/oeManagementDtl";
	}	

	@RequestMapping("InsertOeModal.do")
	@ResponseBody
	public Map<String, Object> InsertOeModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".InsertOeModal");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		
		String action = (String)paramMap.get("action");
		
		System.out.println("InsertOeModal paramMap:"+paramMap);
		System.out.println("InsertOeModal action:"+action);
		
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		oeManagementService.insertOeModal(paramMap);
		OeModalModel oeManagementDtlListModel = oeManagementService.selectSUOeModal(paramMap);

		System.out.println("oeManagementDtlListModel suju:::::::::::::::::"+oeManagementDtlListModel);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("suju", oeManagementDtlListModel);
		logger.info("+ End " + className + ".InsertOeModal");
		
		return resultMap;
		
	}
	
	@RequestMapping("InsertOeDtlModal.do")
	@ResponseBody
	public Map<String, Object> InsertOeDtlModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".InsertOeDtlModal");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		
		System.out.println("InsertOeDtlModal paramMap:"+paramMap);
		System.out.println("InsertOeDtlModal action:"+action);
		
		
		String result = "SUCCESS";
		String resultMsg = "";
		
		int check = oeManagementService.InsertOeDtlModal(paramMap);
		
		if(check == -1 || check == 0){
			resultMsg = "중복되는 데이터가 있으므로 수정으로 진행해주세요"; 
			result = "FAIL"; 
		}else{
			resultMsg = "저장 되었습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".InsertOeDtlModal");
		
		return resultMap;
		
	}
	
	@RequestMapping("OeManagementOne.do")
	@ResponseBody
	public Map<String, Object> OeManagementOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".OeManagementOne");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		
		System.out.println("OeManagementOne paramMap"+paramMap);
		
		System.out.println("OeManagementOne action:"+action);

		//OeModalModel oeManagementDtlListModel = oeManagementService.selectSUOeModal(paramMap);
		OeModalModel oeManagementOne = oeManagementService.oneDtlModal(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("oeManagementOne", oeManagementOne); 
		//resultMap.put("result", result);
		//resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".oeManagementOne");
		
		return resultMap;
		
	}
	
	/*지출 결의 수정  및 삭제 */
	@RequestMapping("fDelOeDtl.do")
	@ResponseBody
	public Map<String, Object> fDelOeDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".fDelOeDtl");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("fDelOeDtl Controller paramMap:::::::::::"+paramMap);
		
		String result = "SUCCESS";
		String resultMsg = "처리 되었습니다.";
		
		String action = (String) paramMap.get("action");
		
		System.out.println("empDvUpdateDelModal action:"+action);
		
		int resultvalue = oeManagementService.deleteInEmpDvDtl(paramMap);
	
		if(resultvalue == 1){
			 result = "SUCCESS";
			 resultMsg = "처리 되었습니다.";
		}else{
			 resultMsg = "문제가 발생하였습니다."; 
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		resultMap.put("result", result); 
		resultMap.put("resultMsg", resultMsg); 
		
		logger.info("+ End " + className + ".fDelOeDtl");
		
		return resultMap;
		
	} 
	
}

