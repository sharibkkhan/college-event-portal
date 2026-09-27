package com.collegeevent.model;

public class Registration {

    private int registrationId;
    private int studentId;
    private int eventId;
    private String registrationDate;
    private String status;

    public Registration() {
    }

    public Registration(int registrationId, int studentId, int eventId,
                        String registrationDate, String status) {

        this.registrationId = registrationId;
        this.studentId = studentId;
        this.eventId = eventId;
        this.registrationDate = registrationDate;
        this.status = status;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}