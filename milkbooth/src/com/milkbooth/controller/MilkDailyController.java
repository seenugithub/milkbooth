package com.milkbooth.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.milkbooth.services.DailyService;


@Controller
@RequestMapping("/daily")
public class MilkDailyController {

	@Autowired
	DailyService DailyService;
	
	@RequestMapping("/page")
	public String loadPage(HttpServletRequest request) {
		System.out.println("Inside MilkDailyController - loadPage()");
		String todayDate=new SimpleDateFormat("dd/MM/yyyy").format(new Date()) ;
		request.setAttribute("todayDate",todayDate);
		return "dailyreport";
	}
	
	@RequestMapping("/load")
	public String loadTransaction(HttpServletRequest request) {
		System.out.println("Inside MilkDailyController - loadTransaction()");
		String todayDate=new SimpleDateFormat("dd/MM/yyyy").format(new Date()) ;
		List<Map<String,Object>> transList= DailyService.getCustomerTransactionListByDate(todayDate);
		request.setAttribute("transList", transList);
		request.setAttribute("todayDate",todayDate);
		return "dailyreport";
	}
	
	@RequestMapping("/savetrans")
	public void saveTransaction(HttpServletRequest request, HttpServletResponse response ) {
		System.out.println("Inside MilkDailyController - saveTransaction()");
		try {
			String resp = DailyService.saveTransaction(request);
			PrintWriter out =response.getWriter();
			out.print(resp);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping("/transdata.do")
	public void transdata(HttpServletRequest request, HttpServletResponse response ) {
		System.out.println("Inside MilkDailyController - transdata()");
		String pdate=request.getParameter("date") ;
		//String dtsession=request.getParameter("dtsession") ;
		try {
			
			JSONObject json = DailyService.prepareDateRow(pdate);
			
			PrintWriter out =response.getWriter();
			out.print(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
