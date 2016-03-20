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

@Service("BillService")
public class BillService {

	@Autowired
	DataSource dataSource;
	
	public List<Map<String,Object>> getBill(String fromDate,String toDate) {
		StringBuffer SQL = new StringBuffer();
		SQL.append("SELECT customer_no, \n");
		SQL.append("  nvl(SUM(am_amount),0)+nvl(SUM(pm_amount),0) AS bill_amount \n");
		SQL.append("FROM govardana_milkcenter.customer_transactions \n");
		SQL.append("WHERE trans_date BETWEEN to_date(?,'DD/MM/YYYY') AND to_date(?,'DD/MM/YYYY') \n");
		//SQL.append("AND (am_amount IS NOT NULL \n");
		//SQL.append("OR pm_amount   IS NOT NULL) \n");
		SQL.append("GROUP BY customer_no \n");
		SQL.append("ORDER BY customer_no ASC");
		System.out.println("Bill Query["+fromDate+","+toDate+"] =>"+SQL);
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		List<Map<String,Object>> billresult = jdbcTemplate.queryForList(SQL.toString(),fromDate,toDate);
		System.out.println("Bill Result : "+billresult);
		return billresult;
	}
	
	public List<Map<String,Object>> getBillDetails(String custNo, String fromDate,String toDate) {
		StringBuffer SQL = new StringBuffer();
		SQL.append("SELECT to_char(trans_date,'DD-Mon-YYYY') as trans_date, \n");
		SQL.append("  am_qty, \n");
		SQL.append("  am_fat, \n");
		SQL.append("  am_amount, \n");
		SQL.append("  pm_qty, \n");
		SQL.append("  pm_fat, \n");
		SQL.append("  pm_amount, \n");
		SQL.append("  NVL(am_amount,0)+NVL(pm_amount,0) AS total \n");
		SQL.append("FROM govardana_milkcenter.customer_transactions \n");
		SQL.append("WHERE customer_no=? \n");
		SQL.append("AND trans_date BETWEEN to_date(?,'DD/MM/YYYY') AND to_date(?,'DD/MM/YYYY') \n");
		//SQL.append("AND (am_amount IS NOT NULL \n");
		//SQL.append("OR pm_amount   IS NOT NULL) \n");
		SQL.append("ORDER BY trans_date");
		System.out.println("getBillDetails Query["+custNo+","+fromDate+","+toDate+"] =>"+SQL);
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		List<Map<String,Object>> billresult = jdbcTemplate.queryForList(SQL.toString(),custNo,fromDate,toDate);
		System.out.println("Bill Result : "+billresult);
		return billresult;
	}
}
