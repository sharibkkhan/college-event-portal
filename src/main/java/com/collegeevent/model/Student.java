package com.collegeevent.model;

public class Student extends User {

    private int studentId;
    private String department;
    private String phone;

    public Student() {
    }

    public Student(int studentId, String name, String email,
                   String password, String department, String phone) {

        super(name, email, password);

        this.studentId = studentId;
        this.department = department;
        this.phone = phone;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}