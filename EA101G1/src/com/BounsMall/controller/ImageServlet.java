package com.BounsMall.controller;

import java.io.IOException;
import java.io.InputStream;

import com.BounsMall.model.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
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
	}
}
