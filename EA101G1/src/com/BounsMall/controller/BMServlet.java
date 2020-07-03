package com.BounsMall.controller;

import java.io.*;
import java.util.*;

import javax.print.PrintService;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.BounsMall.model.*;

@MultipartConfig
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
			String url = "ListAll.jsp";
			
			HttpSession session = req.getSession();
			session.setAttribute("list", list);
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		}
		
		if ("getByName".equals(action)) {
			List<BMVO> list = new ArrayList<BMVO>();
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsMall/ListByName.jsp";
			String fail = "/back-end/BounsMall/select_page.jsp";
			
			try {
				String reg = req.getParameter("bon_name");
				if (reg == null || reg.trim().length() == 0) {
					errorMsgs.add("商品名稱: 請勿空白");
				}
				
				if ( !errorMsgs.isEmpty() ) {
					RequestDispatcher failureView = req.getRequestDispatcher(fail);
					failureView.forward(req, res);
					return;
				}
				
				String bon_name = reg;
				BMService bmSvc = new BMService();
				list = bmSvc.getByBonName(bon_name);
				
				req.setAttribute("list", list);
				req.setAttribute("bon_name", bon_name);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("getByName_front".equals(action)) {
			List<BMVO> list = new ArrayList<BMVO>();
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/front-end/BounsMall/ListByName.jsp";
			String fail = "/front-end/BounsMall/select_page.jsp";
			
			try {
				String reg = req.getParameter("bon_name");
				if (reg == null || reg.trim().length() == 0) {
					errorMsgs.add("商品名稱: 請勿空白");
				}
				
				if ( !errorMsgs.isEmpty() ) {
					RequestDispatcher failureView = req.getRequestDispatcher(fail);
					failureView.forward(req, res);
					return;
				}
				
				String bon_name = reg;
				BMService bmSvc = new BMService();
				list = bmSvc.getByBonName(bon_name);
				
				req.setAttribute("list", list);
				req.setAttribute("bon_name", bon_name);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("getAll_ByPtId".equals(action)) {
			List<BMVO> list = new ArrayList<BMVO>();
			String success = "/back-end/BounsMall/ListByPtId.jsp";
			String fail = "/back-end/BounsMall/select_page.jsp";
			
			try {
				String pt_id = req.getParameter("pt_id");
				BMService bmSvc = new BMService();
				list = bmSvc.getByPtId(pt_id);
				
				req.setAttribute("list", list);
				req.setAttribute("pt_id", pt_id);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("getAll_ByPtId_front".equals(action)) {
			List<BMVO> list = new ArrayList<BMVO>();
			String success = "/front-end/BounsMall/ListByPtId.jsp";
			String fail = "/front-end/BounsMall/select_page.jsp";
			
			try {
				String pt_id = req.getParameter("pt_id");
				BMService bmSvc = new BMService();
				list = bmSvc.getByPtId(pt_id);
				
				req.setAttribute("list", list);
				req.setAttribute("pt_id", pt_id);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
			} catch ( Exception e ) {
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String url = "/back-end/BounsMall/select_page.jsp";
			String success = "/back-end/BounsMall/ListOne.jsp";
			
			try {
				String str = req.getParameter("bon_id");
//				String strReg = "^B[0-9]{6}";
//				if ( str == null || ( str.trim()).length() == 0 ) {
//					errorMsgs.add("請輸入商品編號");
//				}

//				if ( !errorMsgs.isEmpty() ) {
//					RequestDispatcher failureView
//						= req.getRequestDispatcher(url);
//					failureView.forward(req, res);
//					return;
//				}
				
				String bon_id = "";
//				try {
//					if ( str.matches(strReg) )
						bon_id = str;
//					else
//						throw new Exception();
//				} catch ( Exception e ) {
//					errorMsgs.add("商品編號格式不正確");
//				}

//				if ( !errorMsgs.isEmpty() ) {
//					RequestDispatcher failureView
//						= req.getRequestDispatcher(url);
//					failureView.forward(req, res);
//					return;
//				}
				
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
		
		if ("getOne_For_Display_front".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String url = "/front-end/BounsMall/select_page.jsp";
			String success = "/front-end/BounsMall/ListOne.jsp";
			
			try {
				String str = req.getParameter("bon_id");
				String bon_id = str;
				
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
		
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsMall/ListAll.jsp";
			String fail = "/back-end/BounsMall/addBM.jsp";
			
			try {
				String bon_name = req.getParameter("bon_name");
				if (bon_name == null || bon_name.trim().length() == 0) {
					errorMsgs.add("商品名稱: 請勿空白");
				}
				
				Integer bon_price = null;
				try {
					bon_price = new Integer (req.getParameter("bon_price").trim());
				} catch (NumberFormatException e) {
					bon_price = null;
					errorMsgs.add("價格請填數字.");
				}
				
				String bon_info = req.getParameter("bon_info").trim();
				if (bon_info == null || bon_info.trim().length() == 0) {
					errorMsgs.add("描述請勿空白");
				}

				Integer bon_stock = 0;
				String rstock = req.getParameter("bon_stock");
				if ( rstock == null || rstock.trim().length() == 0 ) {
					bon_stock = 0;
					errorMsgs.add("現有庫存請勿空白.");
				} else {
					try {
						bon_stock = new Integer (req.getParameter("bon_stock").trim());
					} catch (NumberFormatException e) {
						bon_stock = null;
						errorMsgs.add("現有總庫存請填數字.");
					}
				}
				
//				圖片
				byte[] bon_image = null;
				Part part = req.getPart("bon_image");
				InputStream in = part.getInputStream();
				if ( in.available() > 0 ) {
					bon_image = new byte[in.available()];
					in.read(bon_image);
					in.close();
				} else {
					errorMsgs.add("請選擇圖片");
				}
				
				String pt_id = new String(req.getParameter("pt_id").trim());

				BMVO bmVO = new BMVO();
				
				bmVO.setBon_name(bon_name);
				bmVO.setBon_info(bon_info);
				bmVO.setBon_price(bon_price);
				bmVO.setBon_stock(bon_stock);
				bmVO.setBon_image(bon_image);
				bmVO.setPt_id(pt_id);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bmVO", bmVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher(fail);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				BMService bmSvc = new BMService();
				bmVO = bmSvc.addBM(pt_id, bon_name, bon_price, bon_image, bon_info, bon_stock);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("資料新增失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsMall/updateBM.jsp";
			String fail = "/back-end/BounsMall/ListAll.jsp";
			
			try {
				String bon_id = new String(req.getParameter("bon_id"));
				
				BMService bmSvc = new BMService();
				BMVO bmVO = bmSvc.getByPK(bon_id);
				
				req.setAttribute("bmVO", bmVO);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
				
			} catch ( Exception e ) {
				errorMsgs.add("無法取得要修改的資料：" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsMall/ListAll.jsp" ;
			String fail = "/back-end/BounsMall/updateBM.jsp" ;
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String bon_id = new String(req.getParameter("bon_id").trim());
				
				String pt_id = new String(req.getParameter("pt_id").trim());
				
				String bon_name = req.getParameter("bon_name");
				if (bon_name == null || bon_name.trim().length() == 0 ) {
					errorMsgs.add("商品名稱: 請勿空白");
	            }
				
				Integer bon_price = null;
				try {
					bon_price = new Integer( req.getParameter("bon_price").trim());
				} catch ( NumberFormatException e ) {
					bon_price = null;
					errorMsgs.add("價格請勿空白");
				}
				
				
				byte[] bon_image = getPartByteArray(req);
				if ( bon_image.length == 0 ) {
					BMService bmSvc = new BMService();
					BMVO bmvo = bmSvc.getByPK(bon_id);
					byte[] imareg = bmvo.getBon_image();
					bon_image = imareg;
				}
				
				String bon_info = req.getParameter("bon_info");
				if ( bon_info == null || bon_info.trim().length() == 0 ) {
					errorMsgs.add("商品描述: 請勿空白");
	            }
				
				Integer bon_exchange = null;
				try {
					bon_exchange = new Integer(req.getParameter("bon_exchange"));
				} catch ( NumberFormatException e) {
					bon_exchange = null;
					errorMsgs.add("以兌換數量請填數字.");
				}
				
				Integer bon_stock = null;
				try {
					bon_stock = new Integer(req.getParameter("bon_stock"));
				} catch ( NumberFormatException e ) {
					bon_stock = null;
					errorMsgs.add("總庫存請填數字.");
				}
				
				java.sql.Date bon_addDate = null;
				try {
					bon_addDate = java.sql.Date.valueOf(req.getParameter("bon_addDate").trim());
				} catch (IllegalArgumentException e) {
					bon_addDate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Integer bon_status = null;
				try {
					bon_status = new Integer(req.getParameter("bon_status"));
				} catch ( NumberFormatException e ){
					bon_status = null;
					errorMsgs.add("請輸入上架狀態！");
				}
				
				BMVO bmVO = new BMVO();
				bmVO.setBon_id(bon_id);
				bmVO.setPt_id(pt_id);
				bmVO.setBon_name(bon_name);
				bmVO.setBon_price(bon_price);
				bmVO.setBon_price(bon_price);
				bmVO.setBon_image(bon_image);
				bmVO.setBon_info(bon_info);
				bmVO.setBon_exchange(bon_exchange);
				bmVO.setBon_stock(bon_stock);
				bmVO.setBon_addDate(bon_addDate);
				bmVO.setBon_status(bon_status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bmVO", bmVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher(fail);
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				BMService bmSvc = new BMService();
				bmVO = bmSvc.updateByPk(bon_id, pt_id, bon_name, bon_price, bon_image,
						bon_info, bon_exchange, bon_stock, bon_addDate, bon_status);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("bmVO", bmVO);
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String success = "/back-end/BounsMall/ListAll.jsp" ;
			String fail = "/back-end/BounsMall/ListAll.jsp" ;
			
			try {
				/***************************1.接收請求參數***************************************/
				String bon_id = req.getParameter("bon_id");
				
				/***************************2.開始刪除資料***************************************/
				BMService bmSvc = new BMService();
				bmSvc.deleteByPK(bon_id);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				RequestDispatcher successView = req.getRequestDispatcher(success);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(fail);
				failureView.forward(req, res);
			}
		}
	}
	
	public byte[] getPartByteArray(HttpServletRequest req) throws ServletException, IOException {
		
		Part part = req.getPart("bon_image"); // Servlet3.0 新增了 Part 介面，讓我們方便地進行檔案上傳處理
		
		java.io.InputStream in = part.getInputStream();
		byte[] buf = new byte[in.available()];
		in.read(buf);
		in.close();
		
		return buf;
	}
}
