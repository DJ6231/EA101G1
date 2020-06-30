package com.BounsMall.model;

import java.util.List;

public class BMService {
	
	private BMDAO_interface dao;
	
	public BMService() {
		dao = new BMDAO();
	}
	
	public BMVO addBM( String pt_id, String bon_name, int bon_price, byte[] bon_image,
			String bon_info, int bon_stock ) {
		
		BMVO bmVO = new BMVO();
		
		bmVO.setPt_id(pt_id);
		bmVO.setBon_name(bon_name);
		bmVO.setBon_price(bon_price);
		bmVO.setBon_image(bon_image);
		bmVO.setBon_info(bon_info);
		bmVO.setBon_stock(bon_stock);
		
		return bmVO;
	}
	
	public BMVO updateByPk(String bon_id, String pt_id, String bon_name, int bon_price, byte[] bon_image,
			String bon_info, int bon_exchange, int bon_stock, java.sql.Date bon_addDate, int bon_status ) {
		
		BMVO bmVO = new BMVO();
		
		bmVO.setBon_id(bon_id);
		bmVO.setPt_id(pt_id);
		bmVO.setBon_name(bon_name);
		bmVO.setBon_price(bon_price);
		bmVO.setBon_image(bon_image);
		bmVO.setBon_info(bon_info);
		bmVO.setBon_info(bon_info);
		bmVO.setBon_exchange(bon_exchange);
		bmVO.setBon_stock(bon_stock);
		bmVO.setBon_addDate(bon_addDate);
		bmVO.setBon_status(bon_status);
		
		return bmVO;
	}
	
	public void deleteByPK ( String bon_id ) {
		dao.delete(bon_id);
	}
	
	public BMVO getByPK ( String bon_id ) {
		return dao.findByPrimaryKey(bon_id);
	}
	
	public List<BMVO> getAll() {
		return dao.getAll();
	}
	
	public List<BMVO> getByPtId ( String pt_id ){
		return dao.getByPtId(pt_id);
	}
	
	public List<BMVO> getByBonName ( String bon_name ) {
		return dao.getByBName(bon_name);
	}
}
