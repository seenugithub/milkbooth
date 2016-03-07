package com.milkbooth.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service("DailyService")
public class DailyService {

	@Autowired
	DataSource dataSource;
	public List<Map<String,Object>> getCustomerTransactionListByDate(String date) {
		
		String sql = "SELECT C.CUSTOMER_NO, " +
				"  T.AM_QTY, " +
				"  AM_FAT, " +
				"  AM_AMOUNT, " +
				"  PM_QTY, " +
				"  PM_FAT, " +
				"  PM_AMOUNT " +
				"FROM GOVARDANA_MILKCENTER.CUSTOMER_DETAILS C " +
				"FULL OUTER JOIN " +
				"  (SELECT * " +
				"  FROM GOVARDANA_MILKCENTER.CUSTOMER_TRANSACTIONS " +
				"  WHERE TRANS_DATE=TO_DATE(?,'DD/MM/YYYY') " +
				"  ) T " +
				"ON C.CUSTOMER_NO=T.CUSTOMER_NO " +
				"ORDER BY C.CUSTOMER_NO ASC";

		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		List<Map<String,Object>> transList = jdbcTemplate.queryForList(sql,date);
		System.out.println("transList : "+transList);
		return transList;
	}
	
	public String saveTransaction(HttpServletRequest request){
		String date = request.getParameter("date"); 
		String dtsession = request.getParameter("dtsession");
		String qty = request.getParameter("qty");
		String fat = request.getParameter("fat");
		String custno = request.getParameter("custno");
		String response="success";
		
		try {
			String sql="SELECT COUNT(1) FROM GOVARDANA_MILKCENTER.CUSTOMER_TRANSACTIONS WHERE TRANS_DATE=TO_DATE(?,'DD/MM/YYYY') ";
			JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
			int isExist=jdbcTemplate.queryForObject(sql,new Object[]{date},Integer.class);
			
			if(dtsession!=null && !dtsession.isEmpty()){
				if(isExist==0){
					 sql = "INSERT INTO GOVARDANA_MILKCENTER.CUSTOMER_TRANSACTIONS (CUSTOMER_NO,"+dtsession+"_QTY,"+dtsession+"_FAT,TRANS_DATE,LAST_UPDATE) VALUES(?,?,?,TO_DATE(?,'DD/MM/YYYY'),SYSDATE)";
					 System.out.println(sql);
					 jdbcTemplate.update(sql,new Object[]{custno,qty,fat,date});
				}
				else{
					sql = "UPDATE GOVARDANA_MILKCENTER.CUSTOMER_TRANSACTIONS  SET "+dtsession+"_QTY=?,"+dtsession+"_FAT=?,LAST_UPDATE=SYSDATE WHERE CUSTOMER_NO=? AND TRANS_DATE=TO_DATE(?,'DD/MM/YYYY')";
					 jdbcTemplate.update(sql,new Object[]{qty,fat,custno,date});
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response="failure";
		}
		
		return response;
	}
	
	public JSONObject prepareDateRow(String date){
		
		List<Map<String,Object>> result = getCustomerTransactionListByDate(date);
	
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		
		for(Map<String,Object> map : result){
			JSONArray jarr = new JSONArray();
			jarr.add(map.get("CUSTOMER_NO"));
			jarr.add(map.get("AM_QTY"));
			jarr.add(map.get("AM_FAT"));
			jarray.add(jarr);
		}
		json.put("aaData", jarray);
		System.out.println(json);
		return json;
	}
}
