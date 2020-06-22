package com.BounsOrder.model;

import java.sql.Date;

public class BOVO implements java.io.Serializable {
	private String ord_id;
	private String mem_id;
	private String bon_id;
	private Date ord_Date;
	private String bs_id;

	public String getOrd_id() {
		return ord_id;
	}
	public void setOrd_id(String ord_id) {
		this.ord_id = ord_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getBon_id() {
		return bon_id;
	}
	public void setBon_id(String bon_id) {
		this.bon_id = bon_id;
	}
	public Date getOrd_Date() {
		return ord_Date;
	}
	public void setOrd_Date(Date ord_Date) {
		this.ord_Date = ord_Date;
	}
	public String getBs_id() {
		return bs_id;
	}
	public void setBs_id(String bs_id) {
		this.bs_id = bs_id;
	}
}
