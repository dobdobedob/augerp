package kr.happyjob.study.sales.controller;

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

import kr.happyjob.study.sales.model.DdRevenueModel;
import kr.happyjob.study.sales.service.DdRevenueService;

@Controller
@RequestMapping("/sales/")
public class DdRevenueController {
	
	
	// 처음 로딩될 때 공지사항 연결
	@RequestMapping("ddRevenue.do")
	public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		System.out.println("ddRevenue.do 작동");
		
		
		return "sales/ddRevenue";
	}
	

}
