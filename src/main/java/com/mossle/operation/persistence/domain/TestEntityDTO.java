package com.mossle.operation.persistence.domain;

// Generated by Hibernate Tools
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


public class TestEntityDTO implements java.io.Serializable {
	
    private static final long serialVersionUID = 0L;

    /** 主键. */
    private Long id;

    /** 请假原因. */
    private String reason;

    /** 请假类型. */
    private String type;

    /** 开始日期. */
    private String startDate;

    /** 开始时间. */
    private String startDateTime;

    /** 结束日期. */
    private String endDate;

    /** 结束时间. */
    private String endDateTime;
    
    /** 申请人. */
    private Long userId;
    
    /** 流程实例Id. */
    private String processInstanceId;
    
    public TestEntityDTO() {
    }

    public TestEntityDTO(Long id) {
        this.id = id;
    }

    
    public TestEntityDTO(Long id, String reason, String type,
    		String startDate, String startDateTime, String endDate, String endDateTime,
    		Long userId, String processInstanceId) {
        this.id = id;
        this.reason = reason;
        this.type = type;
        this.startDate = startDate;
        this.startDateTime = startDateTime;
        this.endDate = endDate;
        this.endDateTime = endDateTime;
        this.userId = userId;
        this.processInstanceId = processInstanceId;
    }

    /** @return 主键. */
    public Long getId() {
        return this.id;
    }
    /**
     * @param id
     *            主键.
     */
    public void setId(Long id) {
        this.id = id;
    }


    /** @return 请假原因. */
    public String getReason() {
        return this.reason;
    }

    /**
     * @param reason
     *            请假原因.
     */
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    /** @return 请假类型. */
    public String getType() {
        return this.type;
    }

    /**
     * @param type
     *            请假类型.
     */
    public void setType(String type) {
        this.type = type;
    }
    
    /** @return 开始日期. */
    public String getStartDate() {
        return this.startDate;
    }

    /**
     * @param startDate
     *            开始日期.
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    /** @return 开始时间. */
    public String getStartDateTime() {
        return this.startDateTime;
    }

    /**
     * @param startDateTime
     *            开始时间.
     */
    public void setStartDateTime(String startDateTime) {
        this.startDateTime = startDateTime;
    }

    /** @return 结束日期. */
    public String getEndDate() {
        return this.endDate;
    }

    /**
     * @param endDate
     *            结束日期.
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    /** @return 结束时间. */
    public String getEndDateTime() {
        return this.startDateTime;
    }

    /**
     * @param endDateTime
     *            结束时间.
     */
    public void setEndDateTime(String endDateTime) {
        this.endDateTime = endDateTime;
    }
    
    /** @return 申请人. */
    public Long getUserId() {
        return this.userId;
    }
    /**
     * @param id
     *            申请人.
     */
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    
    /** @return 结束时间. */
    public String getProcessInstanceId() {
        return this.processInstanceId;
    }

    /**
     * @param endDateTime
     *            结束时间.
     */
    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }
}