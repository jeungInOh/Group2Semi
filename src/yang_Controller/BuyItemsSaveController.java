package yang_Controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ohDao.iteminfoDao;
import semiVo.BuylistVo;
import semiVo.LogisticVo;
import yang_dao.BasketDao;
import yang_dao.BuyListDao;
import yang_dao.LogisticDao;

@WebServlet("/buyItemsSave.yang.do")
public class BuyItemsSaveController extends HttpServlet{ //구매한목록,배송정보테이블에 추가
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String item[]=req.getParameterValues("item");
		String amount[]=req.getParameterValues("amount");
		int memid=Integer.parseInt(req.getParameter("memid"));
		String addr=req.getParameter("addr");
		BuyListDao dao=BuyListDao.getInstance();
		LogisticDao logidao=LogisticDao.getInstance();
		iteminfoDao itemdao=iteminfoDao.getInstance();
		int n1=0; // iteminfo에서 구매수량만큼 빼기
		int n2=0; // buylist에 추가하기
		int n3=0; // logistic에 추가하기
		for(int i=0;i<item.length;i++) {
			BuylistVo vo=new BuylistVo(0,
					memid,
					Integer.parseInt(item[i]),
					Integer.parseInt(amount[i]),
					0,null);
			LogisticVo logivo=new LogisticVo(0, memid, 0,
					Integer.parseInt(item[i]),
					addr,null);
			n1=itemdao.finishBuy(Integer.parseInt(item[i]), Integer.parseInt(amount[i]));
			n2=dao.insert(vo);
			if(n1>0 && n2>0) {
				n3=logidao.insert(logivo);
				if(n2<=0) {
					n1=0; n2=0; n3=0;
					break;
				}
			}else {
				n1=0; n2=0; n3=0;
				break;
			}
		}
		if(n1>0 && n2>0 && n3>0) { //성공했으면 장바구니에서도 제거,아이템인포에서 개수만큼 차감
			BasketDao bdao=BasketDao.getInstance();
			bdao.buyDelBasket(memid);
			String itemname[]=req.getParameterValues("itemname"); 
			int totprice=Integer.parseInt(req.getParameter("totprice")); 
			int surtax=(int)Math.round(totprice*0.1); 
			int itemAmount=item.length; 
			ArrayList<BuylistVo> blist=dao.list(memid, "물품준비중");
			BuylistVo bvo=blist.get(0);
			Date buydate=bvo.getBuydate();
			int ordernum=bvo.getBuyid();
			String paywith=req.getParameter("paywith");
			req.setAttribute("totprice", totprice); //총합계금액
			req.setAttribute("repItem", itemname[0]); //대표 아이템이름 뽑아내기
			req.setAttribute("itemAmount", itemAmount); //총 물품 산 개수
			req.setAttribute("surtax", surtax); //부가세
			req.setAttribute("buydate", buydate); //구매날짜
			req.setAttribute("ordernum", ordernum); //구매번호
			req.setAttribute("paywith", paywith); //결제수단
			req.getRequestDispatcher("/jeungIn/main.jsp?spage=/yang/recipt.jsp").forward(req,resp);
		}else {
			req.setAttribute("code", "오류로 인해 결제실패. 관리자에게 문의해주세요.");
			req.getRequestDispatcher("/jeungIn/main.jsp?spage=/yang/buyPage_y.jsp").forward(req, resp);
		}
	}
}
