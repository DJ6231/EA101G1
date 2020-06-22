package com.BounsState.model;

import java.util.List;

public class BSService {
	
	private BSDAO_interface dao;
	
	public BSService() {
		dao = new BSDAO(); 
	}
	
	public BSVO getOneBS ( String bsid ) {
		return dao.findByPrimaryKey(bsid);
	}
	
	public List<BSVO> getAll() {
		return dao.getAll();
	}
}
