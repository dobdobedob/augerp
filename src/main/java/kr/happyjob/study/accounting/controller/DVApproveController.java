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

import kr.happyjob.study.accounting.model.EmpDvModel;
import kr.happyjob.study.accounting.service.DVApproveService;
import kr.happyjob.study.accounting.service.EmpDvService;

@Controller
@RequestMapping("/accounting/")
public class DVApproveController {
	
	@Autowired
	EmpDvService empDvService;
	
	@Autowired
	DVApproveService dVApproveService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 공통코드 관리 초기화면
	 */
	@RequestMapping("DVApprove.do")
	public String initDVApprove(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initDVApprove");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID  = (String) session.getAttribute("loginId");
		String userType = (String) session.getAttribute("userType"); 
		
		model.addAttribute("loginID", loginID); 
		model.addAttribute("userType", userType); 
		
		logger.info("+ End " + className + ".initDVApprove");

		return "accounting/DVApprove";
	}
	
	
	 /* 지출결의서 목록 조회*/
	@RequestMapping("listDVApprove.do")
	public String listDVApprove(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEmpDv");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println("listEmpDv paramMap"+paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 공통 그룹코드 목록 조회
		List<EmpDvModel> listEmpDvModel = dVApproveService.listDVApprove(paramMap);
		model.addAttribute("listEmpDv", listEmpDvModel);
		
		// 공통 그룹코드 목록 카운트 조회
		int totalCount = dVApproveService.countListDVApprove(paramMap);
		model.addAttribute("totalCntEmpDv", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageEmpDv",currentPage);
		
		logger.info("+ End " + className + ".listEmpDv");
		

		return "accounting/DVApproveList";
	}	
	

	/*지출 결의 단건 조회 */
	@RequestMapping("empDVApproveModal.do")
	@ResponseBody
	public Map<String, Object> empDVApproveModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".empDvDtlModal");
		logger.info("   - paramMap : " + paramMap);
		
		
		// 지출결의 단건 조회
		EmpDvModel EmpDvOneModel = dVApproveService.empDVApproveModal(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("EmpDvOneModel", EmpDvOneModel);
		
		logger.info("+ End " + className + ".empDVApproveModal");
		
		return resultMap;
		
	} 
	
	/*지출 결의 수정  및 삭제 */
	@RequestMapping("updateDVApprove.do")
	@ResponseBody
	public Map<String, Object> updateDVApprove(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".updateDVApprove");
		logger.info("   - paramMap : " + paramMap);

		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		
		int sqlresult = 0;
		
		sqlresult = dVApproveService.updateDVApprove(paramMap);

		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ End " + className + ".updateDVApprove");
		
		return returnvalue;
		
	} 
	
	/*파일 다운로드  */
	@RequestMapping("empdvdownloadfileee.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".downloadfile");
		logger.info("   - paramMap : " + paramMap);

		System.out.println("EmpDvController downloadfile paramMap"+ paramMap);
		
		
		EmpDvModel empDvModel = empDvService.selectOneEmpDv(paramMap);

		System.out.println("EmpDvController downloadfile empDvModel"+ empDvModel);

		//물리경로 조회해서 담기 
		String file = empDvModel.getAtt_mul();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(empDvModel.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);

	}
	
}
