package semiVo;

import java.sql.Date;

public class storageVo {
	private int itemid;
	private String itemname;
	private int catid;
	private int price;
	private String factory;
	private String origin;
	private int stock;
	private Date expire;
	private Date storedate;
	private String image;
	private int avail;
	private String catname;
	
	public storageVo() {}
	
	public storageVo(int itemid, String itemname, int catid, int price, String factory, String origin, int stock,
			Date expire, Date storedate, String image, int avail, String catname) {
		super();
		this.itemid = itemid;
		this.itemname = itemname;
		this.catid = catid;
		this.price = price;
		this.factory = factory;
		this.origin = origin;
		this.stock = stock;
		this.expire = expire;
		this.storedate = storedate;
		this.image = image;
		this.avail = avail;
		this.catname = catname;
	}

	public int getItemid() {
		return itemid;
	}
	public void setItemid(int itemid) {
		this.itemid = itemid;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public int getCatid() {
		return catid;
	}
	public void setCatid(int catid) {
		this.catid = catid;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getFactory() {
		return factory;
	}
	public void setFactory(String factory) {
		this.factory = factory;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public Date getExpire() {
		return expire;
	}
	public void setExpire(Date expire) {
		this.expire = expire;
	}
	public Date getStoredate() {
		return storedate;
	}
	public void setStoredate(Date storedate) {
		this.storedate = storedate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getAvail() {
		return avail;
	}
	public void setAvail(int avail) {
		this.avail = avail;
	}
	public String getCatname() {
		return catname;
	}
	public void setCatname(String catname) {
		this.catname = catname;
	}
	
	
}
