package com.BounsState.model;

import java.util.*;
import java.sql.*;

public class BSJDBCDAO implements BSDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String GET_ALL_STMT = 
			"SELECT BS_ID, BS_STAT"
			+ " FROM BOUNS_STATE ORDER BY BS_ID";
	private static final String GET_ONE_STMT =
			"SELECT BS_ID, BS_STAT"
			+ " FROM BOUNS_STATE WHERE BS_ID = ?";

	@Override
	public BSVO findByPrimaryKey(String bs_id) {
		BSVO bsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, bs_id);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bsVO = new BSVO();
				bsVO.setBs_id(rs.getString("BS_ID"));
				bsVO.setBs_stat(rs.getString("BS_STAT"));
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
		return bsVO;
	}

	@Override
	public List<BSVO> getAll() {
		List<BSVO> list = new ArrayList<BSVO>();
		BSVO bsVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bsVO = new BSVO();
				bsVO.setBs_id(rs.getString("BS_ID"));
				bsVO.setBs_stat(rs.getString("BS_STAT"));
				list.add(bsVO);
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
		
		return list;
	}
	
	public static void main( String args[] ) {
		BSJDBCDAO dao = new BSJDBCDAO();
		
		BSVO bsVO1 = dao.findByPrimaryKey("BS001");
		System.out.print(bsVO1.getBs_id() + ",");
		System.out.println(bsVO1.getBs_stat());
		System.out.println("=========================");
		
		List<BSVO> list = dao.getAll();
		for ( BSVO abs : list ) {
			System.out.print(abs.getBs_id() + ",");
			System.out.println(abs.getBs_stat());
			System.out.println("-----------------------");
		}
	}
}
