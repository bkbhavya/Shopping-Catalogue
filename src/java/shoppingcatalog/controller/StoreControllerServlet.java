/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import shoppingcatalog.dao.StoreDAO;
import shoppingcatalog.dto.ItemDTO;
import shoppingcatalog.dto.ItemInfoDTO;

/**
 *
 * @author devanshi
 */
public class StoreControllerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sess=request.getSession();
        String logout=request.getParameter("logout");
        if(logout!=null)
        {
            sess.invalidate();
            response.sendRedirect("login.html");
            return;
        }
        String username=(String)sess.getAttribute("username");
        String itemType=request.getParameter("itemType");
        String itemId=request.getParameter("itemId");
        RequestDispatcher rd=null;
        try
        {
        if(username==null)
        {
            sess.invalidate();
            rd=request.getRequestDispatcher("accessdenied.html");
        }
        else
        {
        if(itemType==null&&itemId==null)
        {
            ArrayList<String> itemList=StoreDAO.getItemTypes();
            request.setAttribute("itemList",itemList);
            rd=request.getRequestDispatcher("seestore.jsp");
        }
        else if(itemType!=null)
        {
            ArrayList<ItemInfoDTO> itemList=StoreDAO.getItemsByType(itemType);
            request.setAttribute("itemList",itemList);
            rd=request.getRequestDispatcher("showitemsbytype.jsp");
        }
        else if(itemId!=null)
        {
            ItemDTO item=StoreDAO.getItemDetails(Integer.parseInt(itemId));
            request.setAttribute("item",item);
            rd=request.getRequestDispatcher("showitemdetails.jsp");
        }
        }
        }
        catch(Exception ex)
        {
            System.out.println("Exception occured"+ex);
            request.setAttribute("exception",ex);
           rd=request.getRequestDispatcher("showexception.jsp");
            ex.printStackTrace();
        }
        finally
        {
            rd.forward(request,response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
