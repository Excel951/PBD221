/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package CRUD.Master;

import CRUD.addProduct;
import javax.swing.table.DefaultTableModel;
import java.sql.*;
import java.sql.Statement;

/**
 *
 * @author Invinity
 */
public class Product extends javax.swing.JFrame {

    public Connection conn1;
    public static ResultSet rs;

    /**
     * Creates new form Product
     */
    public Product() {
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

        tambah = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        cancel = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });

        tambah.setText("Add");
        tambah.addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                tambahComponentShown(evt);
            }
        });
        tambah.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                tambahActionPerformed(evt);
            }
        });

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
        jTable1.addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                jTable1ComponentShown(evt);
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
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 479, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(tambah)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(cancel)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(tambah)
                    .addComponent(cancel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 275, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(40, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void tambahComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_tambahComponentShown
        // TODO add your handling code here:
    }//GEN-LAST:event_tambahComponentShown

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        // TODO add your handling code here:
        try {
            Class.forName("oracle.jdbc.OracleDriver");

            conn1 = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/XE", "market", "123456789");

            Statement st = conn1.createStatement();

            if (conn1 != null) {
//                int i = 0;
//                st = conn1.createStatement();
                rs = st.executeQuery("select * from products order by product_id desc ");
                DefaultTableModel model = new DefaultTableModel();
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
        } catch (SQLException ex) {
//            System.out.println(ex.getMessage());
//            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_formComponentShown

    private void jTable1ComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_jTable1ComponentShown
        // TODO add your handling code here:
    }//GEN-LAST:event_jTable1ComponentShown

    private void tambahActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_tambahActionPerformed
        // TODO add your handling code here:
        this.setVisible(false);
        addProduct k = new addProduct();
        try {
            Statement st = conn1.createStatement();
            rs = st.executeQuery("select * from PRODUCT_CATEGORIES");
            while (rs.next()) {
                k.categoryID.addItem(rs.getString("CATEGORY_NAME"));
            }
            
            rs = st.executeQuery("select product_id from products where product_id = (select max(product_id) from products)");
            while (rs.next()) {
                k.productID.setText(String.valueOf(rs.getInt("product_id")+1));
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
//        k.productID.setVisible(true);
        k.save.setVisible(true);
        k.update.setVisible(false);
        k.delete.setVisible(false);
        k.productID.disable();
//        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        k.setAlwaysOnTop(true);
        k.setBounds(0 + 200, 0 + 200, 400, 600);
        k.toFront();
        k.requestFocus();
        k.setVisible(true);
        k.toFront();
        k.requestFocus();

    }//GEN-LAST:event_tambahActionPerformed

    private void jTable1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseClicked
        // TODO add your handling code here:
        addProduct k = new addProduct();
        Statement st;
        try {
            st = conn1.createStatement();
            rs = st.executeQuery("select * from PRODUCT_CATEGORIES");
            while (rs.next()) {
                k.categoryID.addItem(rs.getString("CATEGORY_NAME"));
            }
            int baris = jTable1.getSelectedRow();
            this.setVisible(false);
            k.setVisible(true);
//        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
            k.setAlwaysOnTop(true);
            k.setBounds(0 + 200, 0 + 200, 400, 600);
            k.toFront();
            k.requestFocus();
            if (baris != -1) {
                int pilih = (Integer.valueOf(jTable1.getValueAt(baris, 5).toString()) - 1);
                k.productID.setText(jTable1.getValueAt(baris, 0).toString());
                k.productID.disable();
                k.productionName.setText(jTable1.getValueAt(baris, 1).toString());
                k.description.setText(jTable1.getValueAt(baris, 2).toString());
                k.standardCost.setText(jTable1.getValueAt(baris, 3).toString());
                k.listPrice.setText(jTable1.getValueAt(baris, 4).toString());
                k.categoryID.setSelectedIndex(pilih);
                k.save.setVisible(false);
                k.update.setVisible(true);
                k.delete.setVisible(true);
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_jTable1MouseClicked

    private void cancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cancelActionPerformed
        // TODO add your handling code here:
        this.setVisible(false);
//        Menu k = new Menu();
//        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
//        k.setAlwaysOnTop(true);
//        k.setBounds(0 + 200, 0 + 200, screenSize.width - 400, screenSize.height - 400);
//        k.toFront();
//        k.requestFocus();
//        k.setVisible(true);
//        k.toFront();
//        k.requestFocus();
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
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Product.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Product().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton cancel;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JButton tambah;
    // End of variables declaration//GEN-END:variables
}
