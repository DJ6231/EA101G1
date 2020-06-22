package com.productType.model;

import java.util.List;
import java.util.Set;

import com.BounsMall.model.BMVO;
//import com.product.model.ProVO;

public class PtService {
	
	private PtDAO_interface dao;
	
	public PtService() {
		dao = new PtDAO();
	}
	
	public List<PtVO> getAll(){
		return dao.getAll();
	}
	
	public PtVO getOneProductType(String pt_id) {
		return dao.findByPrimaryKey(pt_id);
	}
	
//	public Set<ProVO> getProductByPtid(String pt_id){
//		return dao.getProductByPtid(pt_id);
//	}
	
	public Set<BMVO> getBMByPtid( String pt_id ){
		return dao.getBMByPtid(pt_id);
	}
	
}
