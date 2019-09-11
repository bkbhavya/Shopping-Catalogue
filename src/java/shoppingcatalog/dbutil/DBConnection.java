/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author devanshi
 */
public class DBConnection {
    private static Connection conn;
    static
    {
        try
        {
            Class.forName("oracle.jdbc.OracleDriver");
            System.out.println("Driver succesfully loaded!");
         conn=DriverManager.getConnection("jdbc:oracle:thin:@//DESKTOP-NAICR1E:1521/XE","onlineshopping","shopping");
           
        }
        catch(ClassNotFoundException | SQLException ex)
        {
            System.out.println("Exception in opening connection in database."+ex);
        }
    }
    public static Connection getConnection()
    {
        return conn;
    }
    public static void closeConnection()
    {
        try
        {
            conn.close();
        }
        catch(SQLException ex)
        {
            System.out.println("Exception in closing the connection."+ex);
            ex.printStackTrace();
        }
    }
    
}
