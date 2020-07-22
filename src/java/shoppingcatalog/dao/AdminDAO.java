/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import shoppingcatalog.dbutil.DBConnection;
import shoppingcatalog.dto.ItemDTO;

/**
 *
 * @author devanshi
 */
public class AdminDAO {
    private static PreparedStatement ps,ps1,ps2,ps3,ps4,ps5;
    private static Statement st2,st3;
    static
    {
        try
        {
            ps=DBConnection.getConnection().prepareStatement("Insert into store_items values(?,?,?,?,?,?)");
            ps1=DBConnection.getConnection().prepareStatement("Delete from store_items where id=?");
            ps2=DBConnection.getConnection().prepareStatement("select * from store_items where id=?");
            ps3=DBConnection.getConnection().prepareStatement("Select max(id) as count from store_items");
            st2=DBConnection.getConnection().createStatement();
            ps4=DBConnection.getConnection().prepareStatement("Update store_items ITEM_TYPE=?,ITEM_NAME=?,ITEM_PRICE=?,ITEM_DESC=?,ITEM_IMAGE=? where id=?");
            st3=DBConnection.getConnection().createStatement();
        }
        catch(Exception ex)
        {
            System.out.println("Exception"+ex);
            ex.printStackTrace();
        } 
    }
    public static boolean addItem(ItemDTO item)throws SQLException
    {
        ResultSet rs=ps3.executeQuery();
        rs.next();
        int lastId=rs.getInt(1);
        int nextId=lastId+1;
        ps.setInt(1,nextId);
        ps.setString(3,item.getItemName());
        ps.setString(2,item.getItemType());
        ps.setDouble(4,item.getItemPrice());
        ps.setString(5,item.getItemDesc());
        ps.setString(6,item.getItemImage());
        int ans=ps.executeUpdate();
        return (ans!=0);
    }
    public static boolean deleteItem(int itemId)throws SQLException
    {
        ps.setInt(1,itemId);
        int ans=ps.executeUpdate();
        return (ans!=0);
    }
   
    public static ArrayList<Integer> getAllProductId()throws SQLException
    {
       ArrayList<Integer> itemIdList=new ArrayList<Integer>();
       ResultSet rs=st2.executeQuery("Select id from store_items");
        while(rs.next())
        {
            itemIdList.add(rs.getInt(1));
        }

            System.out.println("List is of "+itemIdList.size()+" items");
            return itemIdList; 
    }
    public static boolean updateItem(ItemDTO item)throws SQLException
    {
        ps4.setString(1,item.getItemType());
        ps4.setString(2,item.getItemName());
        ps4.setDouble(3,item.getItemPrice());
        ps4.setString(4,item.getItemDesc());
        ps4.setString(5,item.getItemImage());
        ps4.setInt(6,item.getItemId());
        int ans=ps4.executeUpdate();
        return (ans!=0);
    }
    public static ArrayList<String> getAllUsers()throws SQLException
    {
        ArrayList<String> users=new ArrayList<>();
       ResultSet rs=st2.executeQuery("select username from members where membertype='CUSTOMER'");
       while(rs.next())
       {
           users.add(rs.getString(1));
       }
       return users;
    }
    
    public static boolean deleteUser(String userId)throws SQLException
    {
        PreparedStatement ps5=DBConnection.getConnection().prepareStatement("delete from members where username=? and membertype='CUSTOMER'");
        ps5.setString(1,userId);
        int ans=ps5.executeUpdate();
        return (ans!=0);
    }
}
