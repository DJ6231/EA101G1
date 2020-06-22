package com.BounsMall.model;

import java.util.*;
import java.io.*;
import java.sql.*;

public class BMJDBCDAO implements BMDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, bmVO.getPt_id());
			pstmt.setString(2, bmVO.getBon_name());
			pstmt.setInt(3, bmVO.getBon_price());
			pstmt.setBytes(4, bmVO.getBon_image());
			pstmt.setString(5, bmVO.getBon_info());
			pstmt.setInt(6, bmVO.getBon_stock());
						
			pstmt.executeUpdate();
			
		} catch ( ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, bon_id);
			
			pstmt.executeUpdate();
			
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public List<BMVO> getByPTId(String pt_id) {
		List<BMVO> list = new ArrayList<BMVO>();
		BMVO bmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
			Class.forName(driver);
			
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	
	public static void main(String[] args) throws IOException  {
		BMJDBCDAO dao = new BMJDBCDAO();
		
//		BMVO bmVO1 = new BMVO();
//		bmVO1.setPt_id("PT003");
//		bmVO1.setBon_name("良值二代 皮卡丘配色 震動連發無線手把");
//		bmVO1.setBon_price(98);
//		byte[] pba1 = getPictureByteArray("WebContent/Image/image0011.jpg");
//		bmVO1.setBon_image(pba1);
//		bmVO1.setBon_info("提供保固六個月");
//		bmVO1.setBon_stock(50);
//		dao.insert(bmVO1);
		
//		BMVO bmVO2 = new BMVO();
//		bmVO2.setBon_id("B000006");
//		bmVO2.setBon_name("數碼寶貝世界 -Next Order-");
//		bmVO2.setPt_id("PT010");
//		bmVO2.setBon_price(200);
//		byte[] pba2 = getPictureByteArray("WebContent/Image/image0011.jpg");
//		bmVO2.setBon_image(pba2);
//		bmVO2.setBon_info("主機平台：PSV\r\n" + 
//				"遊戲類型：角色扮演\r\n" + 
//				"發售日期：2017-02-09\r\n" + 
//				"遊戲人數：1人\r\n" + 
//				"製作廠商：NAMCO BANDAI Games\r\n" + 
//				"發行廠商：NAMCO BANDAI Games");
//		bmVO2.setBon_exchange(1);
//		bmVO2.setBon_stock(40);
//		bmVO2.setBon_status(1);
//		dao.update(bmVO2);
		
//		dao.delete("B000008");

//		BMVO bmVO3 = dao.findByPrimaryKey("B000001");
//		System.out.print(bmVO3.getBon_id() + ",");
//		System.out.print(bmVO3.getPt_id() + ",");
//		System.out.print(bmVO3.getBon_name() + ",");
//		System.out.println(bmVO3.getBon_price());
//		System.out.println(bmVO3.getBon_image());
//		System.out.println(bmVO3.getBon_info());
//		System.out.print(bmVO3.getBon_exchange() + ",");
//		System.out.print(bmVO3.getBon_stock() + ",");
//		System.out.print(bmVO3.getBon_addDate() + ",");
//		System.out.print(bmVO3.getBon_status());
//		System.out.println();
//		System.out.println("==============");
		
//		List<BMVO> list = dao.getAll();
//		for ( BMVO abm : list1 ) {
//			System.out.print(abm.getBon_id() + ",");
//			System.out.print(abm.getPt_id() + ",");
//			System.out.print(abm.getBon_name() + ",");
//			System.out.println(abm.getBon_price());
//			System.out.println(abm.getBon_image());
//			System.out.println(abm.getBon_info());
//			System.out.print(abm.getBon_exchange() + ",");
//			System.out.print(abm.getBon_stock() + ",");
//			System.out.print(abm.getBon_addDate() + ",");
//			System.out.print(abm.getBon_status());
//			System.out.println();
//			System.out.println("---------------");
//		}
		
//		List<BMVO> list2 = dao.getByPTId("PT010");
//		for ( BMVO abm1 : list2 ) {
//			System.out.print(abm1.getBon_id() + ",");
//			System.out.print(abm1.getPt_id() + ",");
//			System.out.print(abm1.getBon_name() + ",");
//			System.out.println(abm1.getBon_price());
//			System.out.println(abm1.getBon_image());
//			System.out.println(abm1.getBon_info());
//			System.out.print(abm1.getBon_exchange() + ",");
//			System.out.print(abm1.getBon_stock() + ",");
//			System.out.print(abm1.getBon_addDate() + ",");
//			System.out.print(abm1.getBon_status());
//			System.out.println();
//			System.out.println("---------------");
//		}
		
		List<BMVO> list3 = dao.getByBName("v");
		for ( BMVO abm : list3 ) {
			System.out.print(abm.getBon_id() + ",");
			System.out.print(abm.getPt_id() + ",");
			System.out.print(abm.getBon_name() + ",");
			System.out.println(abm.getBon_price());
			System.out.println(abm.getBon_image());
			System.out.println(abm.getBon_info());
			System.out.print(abm.getBon_exchange() + ",");
			System.out.print(abm.getBon_stock() + ",");
			System.out.print(abm.getBon_addDate() + ",");
			System.out.print(abm.getBon_status());
			System.out.println();
			System.out.println("---------------");
		}
		
	}
}
