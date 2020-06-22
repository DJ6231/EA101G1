package com.FavouriteBouns.model;

import java.util.List;

public class FBService {
	
	private FBDAO_interface dao;
	
	public FBService() {
		dao = new FBDAO();
	}
	
	public FBVO addFB ( String mem_id, String bon_id ) {
		FBVO fbVO = new FBVO();
		
		fbVO.setMem_id(mem_id);
		fbVO.setBon_id(bon_id);
		
		return fbVO;
	}
	
	public void deleteFB ( String mem_id, String bon_id ) {
		dao.delete(mem_id, bon_id);
	}
	
	public FBVO getOneFB ( String mem_id, String bon_id ) {
		return dao.findByPrimaryKey(mem_id, bon_id);
	}
	
	public List<FBVO> getMemFB ( String mem_id ){
		return dao.findByMem_id(mem_id);
	}
	
	public List<FBVO> getAll() {
		return dao.getAll();
	}
}
