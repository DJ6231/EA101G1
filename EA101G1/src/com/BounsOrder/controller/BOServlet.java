package com.BounsOrder.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.BounsOrder.model.*;

public class BOServlet extends HttpServlet {

	public void doGet (HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
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
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/updateBO.jsp";
			String fail = "/back-end/BounsOrder/ListAll.jsp";
			
			try {
				String ord_id = req.getParameter("ord_id");
				
				BOService boSvc = new BOService();
				BOVO boVO = boSvc.getByPK(ord_id);
				
				req.setAttribute("boVO", boVO);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "無法取得要修改的資料" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "update".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListAll.jsp";
			String fail = "/back-end/BounsOrder/updateBO.jsp";
			
			try {
				String ord_id = new String (req.getParameter("ord_id"));
				String mem_id = new String (req.getParameter("mem_id"));
				String bon_id = new String (req.getParameter("bon_id"));
				java.sql.Date ord_Date = java.sql.Date.valueOf(req.getParameter("ord_Date").trim());
				String bs_id = new String (req.getParameter("bs_id"));
				
				BOVO boVO = new BOVO();
				boVO.setOrd_id(ord_id);
				boVO.setMem_id(mem_id);
				boVO.setBon_id(bon_id);
				boVO.setOrd_Date(ord_Date);
				boVO.setBs_id(bs_id);
				
				BOService boSvc = new BOService();
				boVO = boSvc.updateBO(ord_id, mem_id, bon_id, ord_Date, bs_id);
				
				req.setAttribute("boVO", boVO);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "資料修改失敗：" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "insert".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListAll.jsp";
			String fail = "/back-end/BounsOrder/insert.jsp";
			
			try {
				String mem_id = req.getParameter("mem_id");
				if ( mem_id == null || mem_id.trim().length() == 0 ) {
					errorMsgs.add( "會員ID請勿空白" );
				}
				String bon_id = req.getParameter("bon_id");
				if ( bon_id == null || bon_id.trim().length() == 0 ) {
					errorMsgs.add( "商品ID請勿空白" );
				}

				BOVO boVO = new BOVO();
				
				boVO.setMem_id(mem_id);
				boVO.setBon_id(bon_id);

				if ( !errorMsgs.isEmpty() ) {
					req.setAttribute("boVO", boVO);
					RequestDispatcher failureView = req.getRequestDispatcher(fail);
					failureView.forward(req, res);
					return;
				}

				BOService boSvc = new BOService();
				boVO = boSvc.addBO(mem_id, bon_id);
				
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "新增資料失敗" + e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ( "delete".equals(action) ) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsOrder/ListAll.jsp";
			String fail = "/back-end/BounsOrder/ListAll.jsp";
			
			try {
				String ord_id = req.getParameter("ord_id");
				
				BOService boSvc = new BOService();
				boSvc.deleteBO(ord_id);
				
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				errorMsgs.add( "資料刪除失敗" +e.getMessage() );
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
	}
}
