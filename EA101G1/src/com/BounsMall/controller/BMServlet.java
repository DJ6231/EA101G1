package com.BounsMall.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.BounsMall.model.*;

public class BMServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getAll".equals(action)) {
			BMDAO dao = new BMDAO();
			List<BMVO> list = dao.getAll();
			
			HttpSession session = req.getSession();
			session.setAttribute("list", list);
			String url = "/front-end/BounsMall/ListAll.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		}
		
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String url = "/front-end/BounsMall/select_page.jsp";
			String success = "/front-end/BounsMall/ListOne.jsp";
			
			try {
				String str = req.getParameter("BON_ID");
				String strReg = "^B[0-9]{6}";
				if ( str == null || ( str.trim()).length() == 0 ) {
					errorMsgs.add("請輸入商品編號");
				}
				
				String bon_id = "";
				try {
					if ( str.matches(strReg) )
						bon_id = str;
					else
						throw new Exception();
				} catch ( Exception e ) {
					errorMsgs.add("商品編號格式不正確");
				}
				
				BMDAO dao = new BMDAO();
				BMVO bmVO = dao.findByPrimaryKey(bon_id);
				if ( bmVO == null ) {
					errorMsgs.add("查無資料");
				}
				
				if ( !errorMsgs.isEmpty() ) {
					RequestDispatcher failureView
						= req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;
				}
				
				req.setAttribute("bmVO", bmVO);
				RequestDispatcher successView
					= req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "無法取得資料：" + e.getMessage() );
				RequestDispatcher failureView
					= req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
			} catch (Exception e) {
				errorMsgs.add("資料修改失敗：" + e.getMessage());
				RequestDispatcher failureView =
						req.getRequestDispatcher("/BounsMall/addBM.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) {
			
		}
	}
}
