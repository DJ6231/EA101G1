package com.BounsMall.model;

import java.util.*;

public interface BMDAO_interface {
	public void insert(BMVO bmVO);
	public void update(BMVO bmVO);
	public void delete(String bon_id);
	public BMVO findByPrimaryKey(String bon_id);
	public List<BMVO> getAll();
	public List<BMVO> getByPtId( String pt_id );
	public List<BMVO> getByBName( String bon_name );
}
