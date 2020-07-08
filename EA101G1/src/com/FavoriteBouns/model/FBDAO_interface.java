package com.FavoriteBouns.model;

import java.util.List;

public interface FBDAO_interface {
	public void insert(FBVO fbVO);
	public void delete(String mem_id, String bon_id);
	public FBVO findByPrimaryKey(String mem_id , String bon_id);
	public List<FBVO> findByMem_id(String mem_id);
	public List<FBVO> getAll();
}
