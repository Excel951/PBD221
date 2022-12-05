/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package CRUD.Transaction;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.*;

/**
 *
 * @author IDe
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Connection conn1;
        Statement st;
        ResultSet rs;

        try {
            AddOrders ad = new AddOrders();
            Class.forName("oracle.jdbc.OracleDriver");
            conn1 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "market", "123456789");
            st = conn1.createStatement();
            rs = st.executeQuery("select * from CUSTOMERS order by CUSTOMER_ID asc");
            if (ad.listCust.isEmpty() == false) {
                ad.listCust.clear();
            }
            while (rs.next()) {
                ad.listCust.add(rs.getInt("CUSTOMER_ID"));
            }

            rs = st.executeQuery("select * from EMPLOYEES where JOB_TITLE like '%Sales%' order by EMPLOYEE_ID asc");
            if (ad.listSales.isEmpty() == false) {
                ad.listSales.clear();
            }
            while (rs.next()) {
                ad.listSales.add(rs.getInt("EMPLOYEE_ID"));
            }
            
            System.err.println(ad.listCust);
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }

    }
}
