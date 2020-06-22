package com.FavouriteBouns.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

public class FBDAO implements FBDAO_interface {
	
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, fbVO.getMem_id());
			pstmt.setString(2, fbVO.getBon_id());
			
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
	public void delete(String memid, String bonid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, memid);
			pstmt.setString(2, bonid);
			
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
	public FBVO findByPrimaryKey(String memid, String bonid) {
		FBVO fbVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, memid);
			pstmt.setString(2, bonid);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEMID_STMT);
			
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
				list.add(fbVO);
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while ( rs.next() ) {
				fbVO = new FBVO();
				fbVO.setMem_id(rs.getString("MEM_ID"));
				fbVO.setBon_id(rs.getString("BON_ID"));
				list.add(fbVO);
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
				} catch (Exception e ) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}
}
