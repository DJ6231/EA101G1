package com.BounsMall.controller;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.BounsMall.model.BMService;
import com.BounsMall.model.BMVO;

@MultipartConfig
public class ImageServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
	Connection con;
	
	public void doGet ( HttpServletRequest req, HttpServletResponse res )
			throws ServletException, IOException {
		
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		try {
			String bon_id = req.getParameter("bon_id");
			BMService bms = new BMService();
			BMVO bmVO = bms.getByPK(bon_id);
			byte[] buf = bmVO.getBon_image();
			out.write(buf);
		} catch ( Exception e ) {
			InputStream in = getServletContext().getResourceAsStream("/NoData/null2.jpg");
			byte[] bbf = new byte[in.available()];
			in.read(bbf);
			out.write(bbf);
			in.close();
		}
		
//		try {
//			Statement stmt = con.createStatement();
//			String bon_id = req.getParameter("bon_id");
//			ResultSet rs = stmt.executeQuery(
//					"SELECT BON_IMAGE FORM BOUNS_MALL WHERE BON_ID = '" + bon_id + "'");
//			
//			if ( rs.next()) {
//				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("bon_image"));
//				byte[] buf = new byte[4 * 1024];
//				int len;
//				while ( (len = in.read(buf)) != -1 ) {
//					out.write(buf, 0, len);
//				}
//				in.close();
//			} else {
//				res.sendError(HttpServletResponse.SC_NOT_FOUND);
//			}
//			rs.close();
//			stmt.close();
//		} catch ( Exception e ) {
//			InputStream in = getServletContext().getResourceAsStream("/NoData/null2.jpg");
//			byte[] b = new byte[in.available()];
//			in.read(b);
//			out.write(b);
//			in.close();
//		}
	}
	
//	public void init() throws ServletException {
//		try {
//			Context ctx = new 
//		} catch ( NamingException e ) {
//			e.printStackTrace();
//		} catch ( SQLException e ) {
//			e.printStackTrace();
//		}
//	}
}
