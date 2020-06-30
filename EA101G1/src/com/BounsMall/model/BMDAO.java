package com.BounsMall.model;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class BMDAO implements BMDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = ( DataSource ) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch ( NamingException e ) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT =
			"INSERT INTO BOUNS_MALL (BON_ID, PT_ID, BON_NAME, BON_PRICE, BON_IMAGE, BON_INFO, BON_EXCHANGE, BON_STOCK, BON_STATUS )"
					+ " VALUES ('B'||LPAD(TO_CHAR(BOUNS_MALL_SEQ.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, 0, ?, 0)";
	private static final String GET_ALL_STMT =
			"SELECT BON_ID, PT_ID, BON_NAME, BON_PRICE, BON_IMAGE, BON_INFO, BON_EXCHANGE, BON_STOCK, to_char(BON_ADDDATE,'yyyy-mm-dd') BON_ADDDATE, BON_STATUS "
					+ " FROM BOUNS_MALL ORDER BY BON_ID";
	private static final String GET_ONE_STMT =
			"SELECT BON_ID, PT_ID, BON_NAME, BON_PRICE, BON_IMAGE, BON_INFO, BON_EXCHANGE, BON_STOCK, to_char(BON_ADDDATE,'yyyy-mm-dd') BON_ADDDATE, BON_STATUS "
					+ " FROM BOUNS_MALL WHERE BON_ID = ?";
	private static final String DELETE = 
			"DELETE FROM BOUNS_MALL WHERE BON_ID = ?";
	private static final String UPDATE =
			"UPDATE BOUNS_MALL SET PT_ID=?, BON_NAME=?, BON_PRICE=?, BON_IMAGE=?, BON_INFO=?, BON_EXCHANGE=?, BON_STOCK=?, BON_STATUS=?"
					+ " WHERE BON_ID = ?" ;
	private static final String GET_BY_PT_ID =
			"SELECT BON_ID, PT_ID, BON_NAME, BON_PRICE, BON_IMAGE, BON_INFO, BON_EXCHANGE, BON_STOCK, to_char(BON_ADDDATE,'yyyy-mm-dd') BON_ADDDATE, BON_STATUS "
					+ " FROM BOUNS_MALL WHERE PT_ID = ? ORDER BY BON_ID";
	private static final String GET_BY_BON_NAME =
			"SELECT BON_ID, PT_ID, BON_NAME, BON_PRICE, BON_IMAGE, BON_INFO, BON_EXCHANGE, BON_STOCK, to_char(BON_ADDDATE,'yyyy-mm-dd') BON_ADDDATE, BON_STATUS "
					+ " FROM BOUNS_MALL WHERE BON_NAME LIKE ? OR BON_NAME LIKE UPPER(?)" ;
	
	@Override
	public void insert(BMVO bmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, bmVO.getPt_id());
			pstmt.setString(2, bmVO.getBon_name());
			pstmt.setInt(3, bmVO.getBon_price());
			pstmt.setBytes(4, bmVO.getBon_image());
			pstmt.setString(5, bmVO.getBon_info());
			pstmt.setInt(6, bmVO.getBon_stock());
						
			pstmt.executeUpdate();
			
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( con != null ) {
				try {
					con.close();
				} catch (Exception e ) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void update(BMVO bmVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, bmVO.getPt_id());
			pstmt.setString(2, bmVO.getBon_name());
			pstmt.setInt(3, bmVO.getBon_price());
			pstmt.setBytes(4, bmVO.getBon_image());
			pstmt.setString(5, bmVO.getBon_info());
			pstmt.setInt(6, bmVO.getBon_exchange());
			pstmt.setInt(7, bmVO.getBon_stock());
			pstmt.setInt(8, bmVO.getBon_status());
			pstmt.setString(9, bmVO.getBon_id());
			
			pstmt.executeUpdate();
			
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( con != null ) {
				try {
					pstmt.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void delete(String bon_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, bon_id);
			
			pstmt.executeUpdate();

		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( con != null ) {
				try {
					con.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public BMVO findByPrimaryKey(String bon_id) {
		BMVO bmVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, bon_id);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bmVO = new BMVO();
				bmVO.setBon_id(rs.getString("BON_ID"));
				bmVO.setPt_id(rs.getString("PT_ID"));
				bmVO.setBon_name(rs.getString("BON_NAME"));
				bmVO.setBon_price(rs.getInt("BON_PRICE"));
				bmVO.setBon_image(rs.getBytes("BON_IMAGE"));
				bmVO.setBon_info(rs.getString("BON_INFO"));
				bmVO.setBon_exchange(rs.getInt("BON_EXCHANGE"));
				bmVO.setBon_stock(rs.getInt("BON_STOCK"));
				bmVO.setBon_addDate(rs.getDate("BON_ADDDATE"));
				bmVO.setBon_status(rs.getInt("BON_STATUS"));
			}

		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( rs != null ) {
				try {
					rs.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( con != null ) {
				try {
					con.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
		}
		return bmVO;
	}
	
	@Override
	public List<BMVO> getAll() {
		List<BMVO> list = new ArrayList<BMVO>();
		BMVO bmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bmVO = new BMVO();
				bmVO.setBon_id(rs.getString("BON_ID"));
				bmVO.setPt_id(rs.getString("PT_ID"));
				bmVO.setBon_name(rs.getString("BON_NAME"));
				bmVO.setBon_price(rs.getInt("BON_PRICE"));
				bmVO.setBon_image(rs.getBytes("BON_IMAGE"));
				bmVO.setBon_info(rs.getString("BON_INFO"));
				bmVO.setBon_exchange(rs.getInt("BON_EXCHANGE"));
				bmVO.setBon_stock(rs.getInt("BON_STOCK"));
				bmVO.setBon_addDate(rs.getDate("BON_ADDDATE"));
				bmVO.setBon_status(rs.getInt("BON_STATUS"));
				list.add(bmVO);
			}
			
		} catch ( SQLException se ) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if ( rs != null ) {
				try {
					rs.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( pstmt != null ) {
				try {
					pstmt.close();
				} catch (SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
			if ( con != null) {
				try {
					con.close();
				} catch ( SQLException se ) {
					se.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}

	public static byte[] getPictureByteArray(String path ) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		
		try {
			int i;
			while ( ( i = fis.read(buffer) ) != -1 ) {
				baos.write(buffer, 0, i);
			}
		} finally {
			try {
				if ( baos != null ) {
					baos.close();
				}
			} catch ( Exception e ) {
				throw new RuntimeException("Exception. " + e.getMessage());
			}
			try {
				if ( fis != null ) {
					fis.close();
				}
			} catch ( Exception e ) {
				throw new RuntimeException("Exception. " + e.getMessage());
				
			}
		}
		
		return baos.toByteArray();
	}

	@Override
	public List<BMVO> getByPtId(String pt_id) {
		List<BMVO> list = new ArrayList<BMVO>();
		BMVO bmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_PT_ID);
			pstmt.setString(1, pt_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bmVO = new BMVO();
				bmVO.setBon_id(rs.getString("BON_ID"));
				bmVO.setPt_id(rs.getString("PT_ID"));
				bmVO.setBon_name(rs.getString("BON_NAME"));
				bmVO.setBon_price(rs.getInt("BON_PRICE"));
				bmVO.setBon_image(rs.getBytes("BON_IMAGE"));
				bmVO.setBon_info(rs.getString("BON_INFO"));
				bmVO.setBon_exchange(rs.getInt("BON_EXCHANGE"));
				bmVO.setBon_stock(rs.getInt("BON_STOCK"));
				bmVO.setBon_addDate(rs.getDate("BON_ADDDATE"));
				bmVO.setBon_status(rs.getInt("BON_STATUS"));
				list.add(bmVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public List<BMVO> getByBName(String bon_name) {
		List<BMVO> list = new ArrayList<BMVO>();
		BMVO bmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		bon_name = "%" + bon_name + "%" ;
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_BON_NAME);
			pstmt.setString(1, bon_name);
			pstmt.setString(2, bon_name);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				bmVO = new BMVO();
				bmVO.setBon_id(rs.getString("BON_ID"));
				bmVO.setPt_id(rs.getString("PT_ID"));
				bmVO.setBon_name(rs.getString("BON_NAME"));
				bmVO.setBon_price(rs.getInt("BON_PRICE"));
				bmVO.setBon_image(rs.getBytes("BON_IMAGE"));
				bmVO.setBon_info(rs.getString("BON_INFO"));
				bmVO.setBon_exchange(rs.getInt("BON_EXCHANGE"));
				bmVO.setBon_stock(rs.getInt("BON_STOCK"));
				bmVO.setBon_addDate(rs.getDate("BON_ADDDATE"));
				bmVO.setBon_status(rs.getInt("BON_STATUS"));
				list.add(bmVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
}
