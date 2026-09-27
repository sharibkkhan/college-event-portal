package com.collegeevent.model;

public class Admin extends User {

    private int adminId;

    public Admin() {
    }

    public Admin(int adminId, String name, String email,
                 String password) {

        super(name, email, password);
        this.adminId = adminId;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }
}