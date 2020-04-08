package kku;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class KkuDAO {
	
	private Connection conn; //Connection ���۷��� Ÿ���� java.sql.connection Ŭ������
	
	private ResultSet rs;
	
	public KkuDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/KKU?serverTimezone=UTC";
			String dbID="root";
			String dbPassword="dlwldms23";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword); //�ش� ����̹��� Ŭ����
		}catch(Exception e) {
				e.printStackTrace();
			}
		}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
				return ""; // DB����
	}
	
	
	public int getNext() {
		String SQL = "SELECT kkuID FROM KKU ORDER BY kkuID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			
			return 1; // ���簡 ù ��° �Խù��� ���
			
		} catch (Exception e) {
			e.printStackTrace();
		}
				return -1; // DB����
	}
	
	public int write(String kkuTitle, String userID, String kkuContent) {
		String SQL = "INSERT INTO KKU VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, kkuTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, kkuContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
				return -1; // DB����
	}
	
}
