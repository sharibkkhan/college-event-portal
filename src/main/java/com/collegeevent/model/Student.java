package com.collegeevent.model;

public class Student extends User {

    private int studentId;
    private String department;
    private String phone;

    // Profile fields
    private String year;
    private String division;
    private String rollNumber;
    private String prn;


    public Student() {
    }


    // Existing constructor
    // KEEP THIS so existing code does not break
    public Student(int studentId, String name, String email,
                   String password, String department, String phone) {

        super(name, email, password);

        this.studentId = studentId;
        this.department = department;
        this.phone = phone;
    }


    // Full constructor for student profile
    public Student(int studentId, String name, String email,
                   String password, String department, String phone,
                   String year, String division,
                   String rollNumber, String prn) {

        super(name, email, password);

        this.studentId = studentId;
        this.department = department;
        this.phone = phone;
        this.year = year;
        this.division = division;
        this.rollNumber = rollNumber;
        this.prn = prn;
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


    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }


    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }


    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }


    public String getPrn() {
        return prn;
    }

    public void setPrn(String prn) {
        this.prn = prn;
    }
}