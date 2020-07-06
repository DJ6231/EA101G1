package com.BounsOrder.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.BounsOrder.model.*;

public class BOServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet (HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		System.out.print("BOServlet: ");
		
		if ( "getOneForDisplay".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListOne.jsp";
			String fail = "/back-end/BounsOrder/select_page.jsp";
			
			try {
				String ord_id = req.getParameter("ord_id");
				
				BODAO dao = new BODAO();
				BOVO boVO = dao.findByPrimaryKey(ord_id);
				if( boVO == null ) {
					errorMsgs.add( "查無資料" );
				}
				
				req.setAttribute("boVO", boVO);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "無法取得資料" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "getAllByName".equals(action) ) {
			List<BOVO> list = new ArrayList<BOVO>();
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListByName.jsp";
			String fail = "/back-end/BounsOrder/select_page.jsp";
			
			try {
				String bon_id = req.getParameter("bon_id");
				
				BOService boSvc = new BOService();
				list = boSvc.getByBon(bon_id);
				
				req.setAttribute("list", list);
				req.setAttribute("bon_id", bon_id);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "getAllByMember".equals(action) ) {
			List<BOVO> list = new ArrayList<BOVO>();
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListByMember.jsp";
			String fail = "/back-end/BounsOrder/select_page.jsp";
			
			try {
				String mem_id = req.getParameter("mem_id");
				
				BOService boSvc = new BOService();
				list = boSvc.getByMem(mem_id);
				
				req.setAttribute("list", list);
				req.setAttribute("mem_id", mem_id);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "getOne_For_Update".equals(action) ) {
			
		}
		
		if ( "update".equals(action) ) {
			
		}
		
		if ( "insert".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListAll.jsp";
			String fail = "/back-end/BounsOrder/insert.jsp";
			
			try {
				
			} catch ( Exception e ) {
				errorMsgs.add( "新增資料失敗" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "delete".equals(action) ) {
			
		}
		
		System.out.println();
	}
}
