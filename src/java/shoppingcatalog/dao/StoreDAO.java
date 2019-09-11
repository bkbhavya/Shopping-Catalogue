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
import shoppingcatalog.dto.ItemInfoDTO;
import shoppingcatalog.dto.OrderDTO;

/**
 *
 * @author devanshi
 */
public class StoreDAO {
    private static Statement s;
    private static PreparedStatement ps1;
    private static PreparedStatement ps2,ps3,ps4,ps5,ps6;
    static
    {
        try
        {
            s=DBConnection.getConnection().createStatement();
            ps1=DBConnection.getConnection().prepareStatement("select id,item_name from store_items where item_type=?");
            ps2=DBConnection.getConnection().prepareStatement("select * from store_items where id=?");
            ps3=DBConnection.getConnection().prepareStatement("Insert into order_master values(?,?,?,?)");
            ps4=DBConnection.getConnection().prepareStatement("Insert into order_details values(?,?,?)");
            ps5=DBConnection.getConnection().prepareStatement("select count(*) as count from order_master");
            ps6=DBConnection.getConnection().prepareStatement("select order_id,order_amount,order_date from order_master where cust_name=?");
        }
        catch(Exception ex)
        {
            System.out.println("Exception"+ex);
            ex.printStackTrace();
        } 
    }
public static ArrayList<String> getItemTypes()throws SQLException
{
    ArrayList<String> itemList=new ArrayList<String>();
    ResultSet rs=s.executeQuery("Select distinct item_type from store_items");
    while(rs.next())
    {
        itemList.add(rs.getString(1));
    }
    return itemList;
}
public static ArrayList<ItemInfoDTO> getItemsByType(String itemType)throws SQLException
{
    ArrayList<ItemInfoDTO> itemList=new ArrayList<ItemInfoDTO>();
    ps1.setString(1,itemType);
    ResultSet rs=ps1.executeQuery();
    while(rs.next())
    {
        ItemInfoDTO obj=new ItemInfoDTO();
        obj.setItemId(rs.getInt(1));
        obj.setItemName(rs.getString(2));
        itemList.add(obj);
    }
    return itemList;
}
public static ItemDTO getItemDetails(int itemId)throws SQLException
{
    ItemDTO item=null;
    ps2.setInt(1,itemId);
    ResultSet rs=ps2.executeQuery();
    if(rs.next())
    {
        item=new ItemDTO();
        item.setItemId(itemId);
        item.setItemDesc(rs.getString("item_desc"));
        item.setItemImage(rs.getString("item_image"));
        item.setItemName(rs.getString("item_name"));
        item.setItemPrice(rs.getDouble("item_price"));
        item.setItemType(rs.getString("item_type"));
        
    }
    return item;
}
public static boolean addOrder(String custName,ArrayList<ItemDTO> itemList,double totalAmount)throws SQLException
{
    ResultSet rs=ps5.executeQuery();
    rs.next();
    int lastId=rs.getInt(1);
    String nextId="ORD-00"+(lastId+1);
    ps3.setString(1,nextId);
    ps3.setString(2,custName);
    ps3.setDouble(3,totalAmount);
    java.util.Date today=new java.util.Date();
    long ms=today.getTime();
    java.sql.Date currdate=new java.sql.Date(ms);
    ps3.setDate(4,currdate);
    int ans1=ps3.executeUpdate();
    int count=0;
    System.out.println("Record inserted in order master"+ans1);
    for(ItemDTO item:itemList)
    {
        ps4.setString(1, nextId);
        ps4.setString(2,item.getItemName());
        ps4.setDouble(3,item.getItemPrice());
        int ans2=ps4.executeUpdate();
        if(ans2==1)
        {
            ++count;
        }
        System.out.println("Inserted in order details:"+ans2);
        
    }
    return (ans1==1&&count==itemList.size());
    
}
public static ArrayList<OrderDTO> getOrdersByCustomer(String custname)throws SQLException
{
    ps6.setString(1,custname);
    ResultSet rs=ps6.executeQuery();
    ArrayList<OrderDTO> orderList=new ArrayList<OrderDTO>();
    while(rs.next())
    {
        OrderDTO order=new OrderDTO();
        order.setOrderId(rs.getString(1));
        order.setOrderAmount(rs.getDouble(2));
        order.setOrderDate(rs.getDate(3));
        orderList.add(order);
    }
    return orderList;
}
}
