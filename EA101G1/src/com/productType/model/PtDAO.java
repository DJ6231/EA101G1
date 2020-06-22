package com.productType.model;

import java.util.*;

//import com.product.model.ProVO;
import com.BounsMall.model.*;

import java.sql.*;

public class PtDAO implements com.productType.model.PtDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "DANNY";
	String passwd = "123456";

	private static final String INSERT = "INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME) VALUES(?,?)";
	private static final String UPDATE = "UPDATE PRODUCT_TYPE SET TYPENAME=? WHERE PT_ID=?";
	private static final String DELETE = "DELETE FROM PRODUCT_TYPE WHERE PT_ID=?";
	private static final String GET_ALL_STMT = "SELECT PT_ID,TYPENAME FROM PRODUCT_TYPE ORDER BY PT_ID";
	private static final String GET_ONE_STMT = "SELECT PT_ID,TYPENAME FROM PRODUCT_TYPE WHERE PT_ID=?";
//	private static final String GET_PRODUCT_BYPTID_STMT = "SELECT P_ID,PT_ID,P_NAME,P_PRICE,P_IMAGE,P_INFO,P_SALES,P_STOCK,to_char(P_ADD_DATE,'yyyy-mm-dd') P_ADD_DATE ,P_STAT FROM PRODUCT WHERE PT_ID = ? ORDER BY P_ID";
	private static final String GET_BOUNSMALL_BYPTID_STMT = "SELECT * FROM BOUNS_MALL WHERE PT_ID = ? ORDER BY P_ID";
	
	@Override
	public void insert(PtVO ptVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1,ptVO.getPt_id());
			pstmt.setString(2,ptVO.getTypename());
			
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	}
	@Override
	public void update(PtVO ptVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,ptVO.getTypename());
			pstmt.setString(2,ptVO.getPt_id());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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

	}
	@Override
	public void delete(String pt_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try { 
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1,pt_id);
			
			pstmt.executeUpdate();
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	}
	@Override
	public PtVO findByPrimaryKey(String pt_id) {
		PtVO ptVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, pt_id);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ptVO = new PtVO();
				ptVO.setPt_id(rs.getString("pt_id"));
				ptVO.setTypename(rs.getString("typename"));
		
			}
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
		return ptVO;
		
	}
	@Override
	public List<PtVO> getAll() {
		List <PtVO> list = new ArrayList<PtVO>();
		PtVO ptVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ptVO = new PtVO();
				ptVO.setPt_id(rs.getString("pt_id"));
				ptVO.setTypename(rs.getString("typename"));
				list.add(ptVO);
			}
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
//	@Override
//	public Set<ProVO> getProductByPtid(String pt_id){
//		Set<ProVO> set = new LinkedHashSet<ProVO>();
//		ProVO proVO = null;
//	
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//	
//		try {
//			Class.forName(driver);
//	
//			con = DriverManager.getConnection(url,userid,passwd);
//			pstmt = con.prepareStatement(GET_PRODUCT_BYPTID_STMT);
//			pstmt.setString(1, pt_id);
//			rs = pstmt.executeQuery();
//	
//			while (rs.next()) {
//				proVO = new ProVO();
//				proVO.setP_id(rs.getString("p_id"));
//				proVO.setPt_id(rs.getString("pt_id"));
//				proVO.setP_name(rs.getString("p_name"));
//				proVO.setP_price(rs.getDouble("p_price"));
//				proVO.setP_image(rs.getBytes("p_image"));
//				proVO.setP_info(rs.getString("p_info"));
//				proVO.setP_sales(rs.getInt("p_sales"));
//				proVO.setP_stock(rs.getInt("p_stock"));
//				proVO.setP_add_date(rs.getDate("p_add_date"));
//				proVO.setP_stat(rs.getInt("p_stat"));
//				
//				set.add(proVO); // Store the row in the vector
//			}
//	
//			// Handle any SQL errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. "
//					+ e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return set;
//	}
	
	@Override
	public Set<BMVO> getBMByPtid(String pt_id) {
		Set<BMVO> set = new LinkedHashSet<BMVO>();
		BMVO bmVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			Class.forName(driver);
		
			con = DriverManager.getConnection(url,userid,passwd);
			pstmt = con.prepareStatement(GET_BOUNSMALL_BYPTID_STMT);
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
				set.add(bmVO);
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
		return set;
	}
		
}
