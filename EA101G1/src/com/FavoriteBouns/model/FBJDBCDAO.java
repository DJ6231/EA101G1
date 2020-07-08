package com.FavoriteBouns.model;

import java.util.*;
import java.sql.*;

public class FBJDBCDAO implements FBDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "TEST1";
	String passwd = "TEST1";
	
	private static final String INSERT_STMT =
			"INSERT INTO FAVOURITE_BOUNS ( MEM_ID, BON_ID ) VALUES ( ?, ? )";
	private static final String GET_ALL_STMT =
			"SELECT * FROM FAVOURITE_BOUNS ORDER BY MEM_ID";
	private static final String GET_ONE_STMT =
			"SELECT * FROM FAVOURITE_BOUNS WHERE MEM_ID = ? AND BON_ID = ?";
	private static final String GET_MEMID_STMT =
			"SELECT * FROM FAVOURITE_BOUNS WHERE MEM_ID = ?";
	private static final String DELETE =
			"DELETE FROM FAVOURITE_BOUNS WHERE MEM_ID = ? AND BON_ID = ?";

	@Override
	public void insert(FBVO fbVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, fbVO.getMem_id());
			pstmt.setString(2, fbVO.getBon_id());
			
			pstmt.executeUpdate();
			
		}  catch ( ClassNotFoundException e) {
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
	public void delete(String memid, String bonid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, memid);
			pstmt.setString(2, bonid);
			
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
	public FBVO findByPrimaryKey(String memid, String bonid) {
		FBVO fbVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, memid);
			pstmt.setString(2, bonid);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
			}
		} catch ( ClassNotFoundException e) {
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
				} catch (Exception e ) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return fbVO;
	}

	@Override
	public List<FBVO> findByMem_id(String mem_id) {
		List<FBVO> list = new ArrayList<FBVO>();
		FBVO fbVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_MEMID_STMT);
			
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
				list.add(fbVO);
			}
		} catch ( ClassNotFoundException e) {
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
				} catch (Exception e ) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	@Override
	public List<FBVO> getAll() {
		List<FBVO> list = new ArrayList<FBVO>();
		FBVO fbVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
				list.add(fbVO);
			}
		} catch ( ClassNotFoundException e) {
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
				} catch (Exception e ) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}
	
	public static void main ( String args[] ) {
		FBJDBCDAO dao = new FBJDBCDAO();
		
		FBVO fbVO1 = new FBVO();
		fbVO1.setMem_id("M000008");
		fbVO1.setBon_id("B000004");
		dao.insert(fbVO1);
		
		dao.delete("M000001", "B000001");
		
		FBVO fbVO2 = dao.findByPrimaryKey("M000001", "B000003");
		System.out.print(fbVO2.getMem_id() + ",");
		System.out.println(fbVO2.getBon_id());
		System.out.println("=================");
		
		List<FBVO> list1 = dao.findByMem_id("M000001");
		for ( FBVO mfb : list1 ) {
			System.out.print(mfb.getBon_id() + ",");
		}
		System.out.println();
		System.out.println("=================");
		
		List<FBVO> list2 = dao.getAll();
		for ( FBVO afb : list2 ) {
			System.out.print(afb.getMem_id() + ",");
			System.out.println(afb.getBon_id());
			System.out.println("----------------");
		}
	}

}
