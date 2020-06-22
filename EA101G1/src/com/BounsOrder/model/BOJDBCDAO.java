package com.BounsOrder.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BOJDBCDAO implements BODAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT = 
			"INSERT INTO BOUNS_ORDER ( ORD_ID, MEM_ID, BON_ID, BS_ID )"
					+ " VALUES ('BO'||LPAD(TO_CHAR(BOUNS_ORDER_SEQ.NEXTVAL),8,'0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT ORD_ID, MEM_ID, BON_ID, TO_CHAR(ORD_DATE,'yyyy-mm-dd') ORD_DATE, BS_ID"
					+ " FROM BOUNS_ORDER ORDER BY ORD_ID";
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, boVO.getMem_id());
			pstmt.setString(2, boVO.getBon_id());
			pstmt.setString(3, boVO.getBs_id());
			
			pstmt.executeUpdate();
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver."
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
	public void update(BOVO boVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, boVO.getMem_id());
			pstmt.setString(2, boVO.getBon_id());
			pstmt.setString(3, boVO.getBs_id());
			pstmt.setString(4, boVO.getOrd_id());
			
			pstmt.executeUpdate();
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver."
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
	public void delete(String ord_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, ord_id);
			
			pstmt.executeUpdate();
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver."
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
	public BOVO findByPrimaryKey(String ord_id) {
		BOVO boVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, ord_id);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				boVO = new BOVO();
				boVO.setOrd_id(rs.getString("ORD_ID"));
				boVO.setMem_id(rs.getString("MEM_ID"));
				boVO.setBon_id(rs.getString("BON_ID"));
				boVO.setOrd_Date(rs.getDate("ORD_DATE"));
				boVO.setBs_id(rs.getString("BS_ID"));
			}
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver."
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch ( ClassNotFoundException e ) {
			throw new RuntimeException("Couldn't load database driver."
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

	public static void main ( String args[] ) {
		BOJDBCDAO dao = new BOJDBCDAO();
		
		BOVO boVO1 = new BOVO();
		boVO1.setMem_id("M000009");
		boVO1.setBon_id("B000008");
		boVO1.setBs_id("BS001");
		dao.insert(boVO1);
		
		BOVO boVO2 = new BOVO();
		boVO2.setOrd_id("BO00000009");
		boVO2.setMem_id("M000004");
		boVO2.setBon_id("B000007");
		boVO2.setBs_id("BS002");
		dao.update(boVO2);
		
		dao.delete("BO00000007");
		
		BOVO boVO3 = dao.findByPrimaryKey("BO00000001");
		System.out.print(boVO3.getOrd_id() + ",");
		System.out.print(boVO3.getMem_id() + ",");
		System.out.print(boVO3.getBon_id() + ",");
		System.out.print(boVO3.getOrd_Date() + ",");
		System.out.println(boVO3.getBs_id());
		System.out.println("==================");
		
		List<BOVO> list = dao.getAll();
		for ( BOVO abo : list ) {
			System.out.print(abo.getOrd_id() + ",");
			System.out.print(abo.getMem_id() + ",");
			System.out.print(abo.getBon_id() + ",");
			System.out.print(abo.getOrd_Date() + ",");
			System.out.println(abo.getBs_id());
			System.out.println("----------------");
		}
		
	}
}
