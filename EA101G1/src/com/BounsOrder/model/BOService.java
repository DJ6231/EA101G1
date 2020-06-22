package com.BounsOrder.model;

import java.util.List;

public class BOService {
	
	private BODAO_interface dao;
	
	public BOService() {
		dao = new BODAO();
	}
	
	public BOVO addBO ( String ord_id, String mem_id, String bon_id, java.sql.Date ord_Date,
			String bs_id ) {
		BOVO boVO = new BOVO();
		
		boVO.setOrd_id(ord_id);
		boVO.setMem_id(mem_id);
		boVO.setBon_id(bon_id);
		boVO.setOrd_Date(ord_Date);
		boVO.setBs_id(bs_id);
		
		return boVO;
	}
	
	public BOVO updateBO ( String ord_id, String mem_id, String bon_id, java.sql.Date ord_Date,
			String bs_id ) {
		BOVO boVO = new BOVO();
		
		boVO.setOrd_id(ord_id);
		boVO.setMem_id(mem_id);
		boVO.setBon_id(bon_id);
		boVO.setOrd_Date(ord_Date);
		boVO.setBs_id(bs_id);
		
		return boVO;
	}
	
	public void deleteBO ( String ord_id ) {
		dao.delete(ord_id);
	}
	
	public BOVO getOneBM ( String ord_id ) {
		return dao.findByPrimaryKey(ord_id);
	}
	
	public List<BOVO> getAll() {
		return dao.getAll();
	}
}
