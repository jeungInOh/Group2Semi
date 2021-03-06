package com.jeon.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jeon.Dao.MemberinfoDao;

import org.json.JSONObject;
@WebServlet("/auth/tmpuser.do")
public class TemporalLoginController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    //새로운임시유저생성
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MemberinfoDao dao = MemberinfoDao.getInstance();
        JSONObject json = new JSONObject();
        String url = req.getParameter("url");
        System.out.println(url);
        int memid = dao.newTempUser();
        if (memid>0) {
            json.append("memid", memid);
            req.getSession().setAttribute("memid", memid);
            req.getSession().setAttribute("tempuser", true);
        }
        resp.sendRedirect(req.getContextPath()+"/"+url);
    }
}
