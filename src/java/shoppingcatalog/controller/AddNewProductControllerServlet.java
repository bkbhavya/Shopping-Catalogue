/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import shoppingcatalog.dao.AdminDAO;
import shoppingcatalog.dao.StoreDAO;
import shoppingcatalog.dto.ItemDTO;

/**
 *
 * @author devanshi
 */
public class AddNewProductControllerServlet extends HttpServlet {

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
        String prodop=request.getParameter("prodop");
        String itemId=request.getParameter("id");
        boolean result=false;
        RequestDispatcher rd=null;
        try
        {
            if(prodop.equals("del"))
            {
                result=AdminDAO.deleteItem(Integer.parseInt(itemId));
            }
            else 
            {
                ServletFileUpload sfu=new ServletFileUpload(new DiskFileItemFactory());
                List<FileItem> multiparts=sfu.parseRequest(new ServletRequestContext(request));
                System.out.println("Size is: "+multiparts.size());
                ArrayList<String> obj=new ArrayList<>();
                for(FileItem item:multiparts)
                {
                    if(item.isFormField())
                    {
                        String fieldName=item.getFieldName();
                        String fieldValue=item.getString();
                        System.out.println(fieldName+":"+fieldValue);
                        obj.add(fieldValue);
                    }
                    else
                    {
                        String fieldName=item.getFieldName();
                        String fileName=item.getName();
                        obj.add(fileName);
                        System.out.println(fieldName+":"+fileName);
                        InputStream fileContent=item.getInputStream();
                        System.out.println("Content:"+fileContent);
                        String imgpath="G:\\NetBeansProjects\\MyShoppingCatalogue\\web\\images";
                        System.out.println("ImagePath:"+imgpath);
                        File myfile=new File(imgpath+"\\"+fileName);
                        System.out.println("File will be created at:"+myfile.getAbsolutePath());
                        System.out.println("File created:"+myfile.createNewFile());
                        item.write(myfile);
                        System.out.println("File created at:"+myfile.getAbsolutePath());

                    }
                }
                ItemDTO obje=new ItemDTO();
                obje.setItemImage(obj.get(0));
                obje.setItemName(obj.get(1));
                obje.setItemType(obj.get(2));
                obje.setItemDesc(obj.get(3));
                obje.setItemPrice(Double.parseDouble(obj.get(4)));
                if(prodop.equals("update"))
                {
                    result=AdminDAO.updateItem(obje);
                }
                else
                {
                result=AdminDAO.addItem(obje);
                }
                }
        if(result==true)
        {
            rd=request.getRequestDispatcher("success.jsp");
        }
        else
        {
             rd=request.getRequestDispatcher("failure.jsp");
        }
    }
        catch (Exception ex) {
                rd=request.getRequestDispatcher("showexception.jsp");
                request.setAttribute("ex", ex);
                System.out.println("Exception:"+ex);
                ex.printStackTrace();
            }
        finally
        {
            rd.forward(request, response);
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
