package com.BounsOrder.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class BODAO implements BODAO_interface {
	
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
			"INSERT INTO BOUNS_ORDER ( ORD_ID, MEM_ID, BON_ID, BS_ID )"
					+ " VALUES ('BO'||LPAD(TO_CHAR(BOUNS_ORDER_SEQ.NEXTVAL),8,'0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT ORD_ID, MEM_ID, BON_ID, TO_CHAR(ORD_DATE,'yyyy-mm-dd') ORD_DATE, BS_ID"
					+"FROM BOUNS_ORDER ORDER BY ORD_ID";
	private static final String GET_ONE_STMT = 
			"SELECT ORD_ID, MEM_ID, BON_ID, TO_CHAR(ORD_DATE,'yyyy-mm-dd') ORD_DATE, BS_ID"
					+ " FROM BOUNS_ORDER WHERE ORD_ID = ?";
	private static final String DELETE = 
			"DELETE FROM BOUNS_ORDER WHERE ORD_ID=?";
	private static final String UPDATE = 
			"UPDATE BOUNS_ORDER SET MEM_ID=?, BON_ID=?, BS_ID=?"
					+ "WHERE ORD_ID=? ";
	
	@Override
	public void insert(BOVO boVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, boVO.getMem_id());
			pstmt.setString(2, boVO.getBon_id());
			pstmt.setString(3, boVO.getBs_id());
			
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
	public void update(BOVO boVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, boVO.getMem_id());
			pstmt.setString(2, boVO.getBon_id());
			pstmt.setString(3, boVO.getBs_id());
			pstmt.setString(4, boVO.getOrd_id());
			
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
	public void delete(String ordid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, ordid);
			
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
	public BOVO findByPrimaryKey(String ordid) {
		BOVO boVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, ordid);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				boVO = new BOVO();
				boVO.setOrd_id(rs.getString("ORD_ID"));
				boVO.setMem_id(rs.getString("MEM_ID"));
				boVO.setBon_id(rs.getString("BON_ID"));
				boVO.setOrd_Date(rs.getDate("ORD_DATE"));
				boVO.setBs_id(rs.getString("BS_ID"));
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
		return boVO;
	}

	@Override
	public List<BOVO> getAll() {
		List<BOVO> list = new ArrayList<BOVO>();
		BOVO boVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				boVO = new BOVO();
				boVO.setOrd_id(rs.getString("ORD_ID"));
				boVO.setMem_id(rs.getString("MEM_ID"));
				boVO.setBon_id(rs.getString("BON_ID"));
				boVO.setOrd_Date(rs.getDate("ORD_DATE"));
				boVO.setBs_id(rs.getString("BS_ID"));
				list.add(boVO);
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
