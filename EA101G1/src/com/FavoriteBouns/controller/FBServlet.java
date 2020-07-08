package com.FavoriteBouns.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.FavoriteBouns.model.*;

public class FBServlet extends HttpServlet {
	
	public void doGet (HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		doPost(req, res );
	}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.print("FBServlet: ");
		
		if ( "getOneForDisplay".equals(action) ) {
			
		}
		
		if ( "getAllByMember".equals(action) ) {
			
		}
		
		if ( "insert".equals(action) ) {
			
		}
		
		if ( "delete".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/FavoriteBouns/ListAll.jsp";
			String fail = "/back-end/FavoriteBouns/ListAll.jsp";

			try {
				String mem_id = req.getParameter("mem_id");
				String bon_id = req.getParameter("bon_id");
				
				FBService fbSvc = new FBService();
				fbSvc.deleteFB(mem_id, bon_id);
				
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "資料刪除失敗" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		System.out.println();
		
	}
}
