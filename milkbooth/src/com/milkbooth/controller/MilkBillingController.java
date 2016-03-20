package com.milkbooth.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.milkbooth.services.BillService;

@Controller
@RequestMapping("/billing")
public class MilkBillingController {

	@Autowired
	BillService BillService;
	
	@RequestMapping("/page")
	public String loadPage(HttpServletRequest request) {
		System.out.println("Inside MilkBillingController - loadPage()");
		
		return "billing";
	}
	
	@RequestMapping("/load")
	public String loadBill(HttpServletRequest request) {
		System.out.println("Inside MilkBillingController - loadBill()");
		String fromDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		List<Map<String,Object>> bills=BillService.getBill(fromDate, toDate);
		request.setAttribute("bills", bills);
		return "billing";
	}
	
	@RequestMapping("/viewbilldetails")
	public String viewbilldetails(HttpServletRequest request) {
		System.out.println("Inside MilkBillingController - viewbilldetails()");
		String custNo = request.getParameter("custno");
		String fromDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		List<Map<String,Object>> billdetails=BillService.getBillDetails(custNo, fromDate, toDate);
		request.setAttribute("billdetails", billdetails);
		return "billdetails";
	}
	
	@RequestMapping("/printbill")
	public String printbill(HttpServletRequest request) {
		System.out.println("Inside MilkBillingController - loadBill()");
		String fromDate = request.getParameter("fromdate");
		String toDate = request.getParameter("todate");
		List<Map<String,Object>> bills=BillService.getBill(fromDate, toDate);
		request.setAttribute("bills", bills);
		return "printbill";
	}
}
