/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CRUD.Transaction;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.table.DefaultTableModel;
import static CRUD.Transaction.AddOrders.productid;
import static CRUD.Transaction.AddOrders.productname;
import static CRUD.Transaction.AddOrders.unitprice;

/**
 *
 * @author User
 */
public class listProductOrders extends javax.swing.JFrame {

    /**
     * Creates new form listProductOrders
     */
    public Connection conn1;
    public Statement st;
    public ResultSet rs;

    public listProductOrders() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        searchField = new javax.swing.JTextField();
        cari = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        cancel = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });

        cari.setText("Cari");
        cari.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cariActionPerformed(evt);
            }
        });

        jLabel1.setText("Search");

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        jTable1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTable1MouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(jTable1);

        cancel.setText("Cancel");
        cancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cancelActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 528, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(22, 22, 22)
                        .addComponent(searchField, javax.swing.GroupLayout.PREFERRED_SIZE, 137, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(cari)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(cancel)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cari)
                    .addComponent(searchField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1)
                    .addComponent(cancel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 280, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    DefaultTableModel model = new DefaultTableModel();

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        // TODO add your handling code here:
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            conn1 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "market", "123456789");
            if (conn1 != null) {
                int i = 0;
                st = conn1.createStatement();
                rs = st.executeQuery("select * from products order by product_id desc ");
                model.addColumn("ID");
                model.addColumn("NAME");
                model.addColumn("DESCRIPTION");
                model.addColumn("COST");
                model.addColumn("PRICE");
                model.addColumn("CATEGORY");
                while (rs.next()) {

                    String id = rs.getString("PRODUCT_ID");
                    String name = rs.getString("PRODUCT_NAME");
                    String description = rs.getString("DESCRIPTION");
                    String cost = rs.getString("STANDARD_COST");
                    String price = rs.getString("LIST_PRICE");
                    String category = rs.getString("CATEGORY_ID");

                    model.addRow(new Object[]{id, name, description, cost, price, category});
                }
                jTable1.setModel(model);

//                conn1.close();
            } else {

            }
        } catch (ClassNotFoundException ex) {

        } catch (SQLException ex) {

        }
    }//GEN-LAST:event_formComponentShown

    private void jTable1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseClicked
        // TODO add your handling code here:
        int baris = jTable1.getSelectedRow();
        if (baris != -1) {
            productid.setText(jTable1.getValueAt(baris, 0).toString());
            productname.setText(jTable1.getValueAt(baris, 1).toString());
            unitprice.setText(jTable1.getValueAt(baris, 4).toString());
        }

        this.setVisible(false);


    }//GEN-LAST:event_jTable1MouseClicked

    private void cariActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cariActionPerformed
        try {
            // TODO add your handling code here:
            Class.forName("oracle.jdbc.OracleDriver");
            conn1 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "market", "123456789");
            if (conn1 != null) {
                st = conn1.createStatement();
                String sql = "SELECT p.*"
                        + "FROM PRODUCTS p "
                        + "JOIN PRODUCT_CATEGORIES pc ON pc.CATEGORY_ID = p.CATEGORY_ID "
                        + "WHERE p.PRODUCT_ID LIKE '%" + searchField.getText() + "%' OR p.PRODUCT_NAME LIKE '%" + searchField.getText() + "%' OR p.DESCRIPTION LIKE '%" + searchField.getText() + "%' OR pc.CATEGORY_NAME LIKE '%" + searchField.getText() + "%'"
                        + "ORDER BY p.CATEGORY_ID, p.PRODUCT_ID asc";
                rs = st.executeQuery(sql);
                model.setRowCount(0);
                while (rs.next()) {
                    String id = rs.getString("PRODUCT_ID");
                    String name = rs.getString("PRODUCT_NAME");
                    String description = rs.getString("DESCRIPTION");
                    String cost = rs.getString("STANDARD_COST");
                    String price = rs.getString("LIST_PRICE");
                    String category = rs.getString("CATEGORY_ID");
                    
                    model.addRow(new Object[]{id, name, description, cost, price, category});
                }
//                jTable1

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(listProductOrders.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(listProductOrders.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cariActionPerformed

    private void cancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cancelActionPerformed
        // TODO add your handling code here:
        this.setVisible(false);
    }//GEN-LAST:event_cancelActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(listProductOrders.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(listProductOrders.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(listProductOrders.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(listProductOrders.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new listProductOrders().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton cancel;
    private javax.swing.JButton cari;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JTextField searchField;
    // End of variables declaration//GEN-END:variables
}
