package com.BounsOrder.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.BounsOrder.model.BODAO;
import com.BounsOrder.model.BOVO;

public class BOServlet extends HttpServlet {
	public void doGet (HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
				
		if ( "getOne_For_Display".equals(action) ) {
			
		}
		
		if ( "getOne_For_Update".equals(action) ) {
			
		}
		
		if ( "update".equals(action) ) {
			
		}
		
		if ( "insert".equals(action) ) {
			
		}
		
		if ( "delete".equals(action) ) {
			
		}
	}
}
