package com.collegeevent.model;

public class Event {

    private int eventId;
    private String eventName;
    private String description;
    private String eventDate;
    private String eventTime;
    private String venue;
    private int maxParticipants;
    private int createdBy;

    public Event() {
    }

    public Event(int eventId, String eventName, String description,
                 String eventDate, String eventTime, String venue,
                 int maxParticipants, int createdBy) {

        this.eventId = eventId;
        this.eventName = eventName;
        this.description = description;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.venue = venue;
        this.maxParticipants = maxParticipants;
        this.createdBy = createdBy;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(int maxParticipants) {
        this.maxParticipants = maxParticipants;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }
}