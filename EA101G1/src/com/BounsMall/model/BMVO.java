package com.BounsMall.model;

import java.sql.Date;

public class BMVO implements java.io.Serializable {
	private String bon_id;
	private String pt_id;
	private String bon_name;
	private Integer bon_price;
	private byte[] bon_image;
	private String bon_info;
	private Integer bon_exchange;
	private Integer bon_stock;
	private Date bon_addDate;
	private Integer bon_status;
	
	public String getBon_id() {
		return bon_id;
	}
	public void setBon_id(String bon_id) {
		this.bon_id = bon_id;
	}
	public String getPt_id() {
		return pt_id;
	}
	public void setPt_id(String pt_id) {
		this.pt_id = pt_id;
	}
	public String getBon_name() {
		return bon_name;
	}
	public void setBon_name(String bon_name) {
		this.bon_name = bon_name;
	}
	public Integer getBon_price() {
		return bon_price;
	}
	public void setBon_price(Integer bon_price) {
		this.bon_price = bon_price;
	}
	public byte[] getBon_image() {
		return bon_image;
	}
	public void setBon_image(byte[] bon_image) {
		this.bon_image = bon_image;
	}
	public String getBon_info() {
		return bon_info;
	}
	public void setBon_info(String bon_info) {
		this.bon_info = bon_info;
	}
	public Integer getBon_exchange() {
		return bon_exchange;
	}
	public void setBon_exchange(Integer bon_exchange) {
		this.bon_exchange = bon_exchange;
	}
	public Integer getBon_stock() {
		return bon_stock;
	}
	public void setBon_stock(Integer bon_stock) {
		this.bon_stock = bon_stock;
	}
	public Date getBon_addDate() {
		return bon_addDate;
	}
	public void setBon_addDate(Date bon_addDate) {
		this.bon_addDate = bon_addDate;
	}
	public Integer getBon_status() {
		return bon_status;
	}
	public void setBon_status(Integer bon_status) {
		this.bon_status = bon_status;
	}

}