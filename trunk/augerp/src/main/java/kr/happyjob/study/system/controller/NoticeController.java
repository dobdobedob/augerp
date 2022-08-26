package kr.happyjob.study.system.controller;

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


import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("notice.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".initNotice");
		logger.info("   - paramMap : " + paramMap);
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);		
		model.addAttribute("loginId", loginID);
		
		return "system/notice";
	}
	
	
	
	
	@RequestMapping("listnotice.do")
	public String listComnGrpCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		

	    int curpage = Integer.parseInt((String) paramMap.get("curpage"));
	    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageIndex = (curpage - 1) * pageSize;
	    
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		List<NoticeModel> listNoticeModel = noticeService.listNoticeModel(paramMap);
		
		int totNoticeModel = noticeService.totNoticeModel(paramMap);
		
		model.addAttribute("listNoticeModel", listNoticeModel);
		model.addAttribute("totNoticeModel", totNoticeModel);
		
		model.addAttribute("curpage", curpage);
		model.addAttribute("pageSize", pageSize);		
		
		logger.info("+ Stop " + className + ".listComnGrpCod");
		
		return "system/noticeList";
	}	
		
		
	@RequestMapping("selectnotice.do")
	@ResponseBody
	public Map<String, Object> selectnotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectnotice");
		logger.info("   - paramMap : " + paramMap);
		
		NoticeModel noticeModel = noticeService.selectnotice(paramMap);
				
		noticeService.updatenoticereadcnt(paramMap);
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		returnvalue.put("noticeModel", noticeModel);
		
		logger.info("+ Stop " + className + ".selectnotice");
		
		return returnvalue;
	}	
	
	
	
	@RequestMapping("savenotice.do")
	@ResponseBody
	public Map<String, Object> savenotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savenotice");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
		
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			sqlresult = noticeService.insertnotice(paramMap);
		} else if("U".equals(action)) {  // 수정
			sqlresult = noticeService.updatenotice(paramMap);
		} else if("D".equals(action)) {  // 수정
			sqlresult = noticeService.deletenotice(paramMap);
		}
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".savenotice");
		
		return returnvalue;
	}		
	
	@RequestMapping("savenoticefile.do")
	@ResponseBody
	public Map<String, Object> savenoticefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savenoticefile");
		logger.info("   - paramMap : " + paramMap);
		
		String sucessresult = "SUCCESS";
		String failresult = "FAIL";
		
		String action = (String) paramMap.get("action");
	
        paramMap.put("loginId", paramMap.get("loginIdfile"));
		paramMap.put("noticeTitle", paramMap.get("noticeTitlefile"));
		paramMap.put("noticeContent", paramMap.get("noticeContentfile"));
        
        
		int sqlresult = 0;
		
		if("I".equals(action)) { // 등록
			noticeService.insertnoticefile(paramMap,request);
		} else if("U".equals(action)) {  // 수정
			noticeService.updatenoticefile(paramMap,request);
		} else if("D".equals(action)) {  // 삭제
			noticeService.deletenoticefile(paramMap);
		}
		
		Map<String, Object> returnvalue = new HashMap<String, Object>();
		
		if(sqlresult == -1) {
			returnvalue.put("result", failresult);
		} else {
			returnvalue.put("result", sucessresult);
		}
		
		
		logger.info("+ Stop " + className + ".savenoticefile");
		
		return returnvalue;
	}	
	
	
	
	@RequestMapping("noticedownloadfile.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".downloadfile");
		logger.info("   - paramMap : " + paramMap);
		
		NoticeModel noticeModel = noticeService.selectnotice(paramMap);
		
		String file = noticeModel.getAtt_mul();
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(noticeModel.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	}		
}
