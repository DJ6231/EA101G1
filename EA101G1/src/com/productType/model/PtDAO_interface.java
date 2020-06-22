package com.productType.model;

import java.util.List;
import java.util.Set;

//import com.product.model.ProVO;
import com.BounsMall.model.*;


public interface PtDAO_interface {
	
	public void insert(PtVO ptVO);
	public void update(PtVO ptVO);
	public void delete(String pt_id);
	public PtVO findByPrimaryKey(String pt_id );
	public List<PtVO> getAll();
//	public Set<ProVO> getProductByPtid(String pt_id);
	public Set<BMVO> getBMByPtid( String pt_id );
}
