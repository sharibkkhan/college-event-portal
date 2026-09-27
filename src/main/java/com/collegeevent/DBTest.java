package com.collegeevent;

import com.collegeevent.util.DBConnection;
import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try (Connection connection = DBConnection.getConnection()) {

            if (connection != null && !connection.isClosed()) {
                System.out.println("=================================");
                System.out.println("DATABASE CONNECTION SUCCESSFUL");
                System.out.println("Database: college_event_portal");
                System.out.println("=================================");
            }

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }
    }
}