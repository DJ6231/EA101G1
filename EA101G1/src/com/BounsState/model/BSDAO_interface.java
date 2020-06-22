package com.BounsState.model;

import java.util.*;

public interface BSDAO_interface {
	public BSVO findByPrimaryKey(String bs_id);
	public List<BSVO> getAll();
}
