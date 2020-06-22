package com.BounsState.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class BSDAO implements BSDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = ( DataSource ) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch ( NamingException e ) {
			e.printStackTrace();
		}
	}

	private static final String GET_ALL_STMT = 
			"SELECT BS_ID, BS_STAT"
			+ " FROM BOUNS_STATE ORDER BY BS_ID";
	private static final String GET_ONE_STMT =
			"SELECT BS_ID, BS_STAT"
			+ " FROM BOUNS_STATE WHERE BS_ID = ?";
	
	@Override
	public BSVO findByPrimaryKey(String bsid) {
		BSVO bsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, bsid);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bsVO = new BSVO();
				bsVO.setBs_id(rs.getString("BS_ID"));
				bsVO.setBs_stat(rs.getString("BS_STAT"));
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				bsVO = new BSVO();
				bsVO.setBs_id(rs.getString("BS_ID"));
				bsVO.setBs_stat(rs.getString("BS_STAT"));
				list.add(bsVO);
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
		
		return list;
	}
}
