package yang_dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import db.DBCPBean;
import semiVo.IteminfoVo;

public class IteminfoDao_y {
	private static IteminfoDao_y instance=new IteminfoDao_y();
	private IteminfoDao_y() {}
	public static IteminfoDao_y getInstance() {
		return instance;
	}
	public ArrayList<IteminfoVo> list(String id,String bd){ //b는 장바구니,d는 찜
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<IteminfoVo> list=new ArrayList<IteminfoVo>();
		String sql="";
		if(bd.equals("d")) {
			sql="SELECT * FROM ITEMINFO NATURAL JOIN BASKET WHERE MEMID=\r\n" + 
				"(SELECT MEMID FROM MEMBERINFO WHERE ID=?) AND COUNT=0 ORDER BY BASID DESC";
		}else if(bd.equals("b")){
			sql="SELECT * FROM ITEMINFO NATURAL JOIN BASKET WHERE MEMID=\r\n" + 
				"(SELECT MEMID FROM MEMBERINFO WHERE ID=?) AND COUNT>0 ORDER BY BASID DESC";
		}
		try {
			con=DBCPBean.getConn();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				IteminfoVo vo=new IteminfoVo(
						rs.getInt("itemid"),
						rs.getString("itemname"),
						rs.getInt("catid"),
						rs.getInt("price"),
						rs.getString("factory"),
						rs.getString("origin"),
						rs.getInt("stock"),
						rs.getDate("expire"),
						rs.getDate("storedate"),
						rs.getString("image"),
						rs.getInt("avail"));
				list.add(vo);
			}
			return list;
		}catch(SQLException se) {
			se.printStackTrace();
			return null;
		}finally {
			DBCPBean.close(rs,pstmt,con);
		}
	}
	public ArrayList<IteminfoVo> list(String id,String bd,int startRow,int endRow){
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ArrayList<IteminfoVo> list=new ArrayList<IteminfoVo>();
		String sql="";
		if(bd.equals("d")) {
			sql="SELECT * FROM(\r\n" + 
					"SELECT ROWNUM RNUM, AA.* FROM\r\n" + 
					"(SELECT * FROM ITEMINFO NATURAL JOIN BASKET WHERE MEMID=\r\n" + 
					"(SELECT MEMID FROM MEMBERINFO WHERE ID=?) AND COUNT=0 ORDER BY BASID DESC) AA\r\n" + 
					") WHERE RNUM>=? AND RNUM<=?";
		}else if(bd.equals("b")){
			sql="SELECT * FROM(\r\n" + 
					"SELECT ROWNUM RNUM, AA.* FROM\r\n" + 
					"(SELECT * FROM ITEMINFO NATURAL JOIN BASKET WHERE MEMID=\r\n" + 
					"(SELECT MEMID FROM MEMBERINFO WHERE ID=?) AND COUNT>0 ORDER BY BASID DESC) AA\r\n" + 
					") WHERE RNUM>=? AND RNUM<=?";
		}
		try {
			con=DBCPBean.getConn();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				IteminfoVo vo=new IteminfoVo(
						rs.getInt("itemid"),
						rs.getString("itemname"),
						rs.getInt("catid"),
						rs.getInt("price"),
						rs.getString("factory"),
						rs.getString("origin"),
						rs.getInt("stock"),
						rs.getDate("expire"),
						rs.getDate("storedate"),
						rs.getString("image"),
						rs.getInt("avail"));
				list.add(vo);
			}
			return list;
		}catch(SQLException se) {
			se.printStackTrace();
			return null;
		}finally {
			DBCPBean.close(rs,pstmt,con);
		}
	}
	public int getCountBasid(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="SELECT NVL(COUNT(BASID),0) CNT FROM ITEMINFO NATURAL JOIN BASKET WHERE MEMID=\r\n" + 
				"(SELECT MEMID FROM MEMBERINFO WHERE ID=?) AND COUNT=0 ORDER BY BASID DESC";
		try{
			con=DBCPBean.getConn();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			rs.next();
			int minBasid=rs.getInt("CNT");
			return minBasid;
		}catch(SQLException se) {
			se.printStackTrace();
			return -1;
		}finally {
			DBCPBean.close(con,pstmt,rs);
		}
	}
}
