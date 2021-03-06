package com.mossle.humantask.persistence.domain;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TaskInfoCopy 抄送已读辅助表.
 * 
 * @author ckx
 */
@Entity
@Table(name = "TASK_INFO_COPY")
public class TaskInfoCopy implements java.io.Serializable {
	
    private static final long serialVersionUID = 0L;

    /** TASK_INFO_COPY 表主键*/
    private Long Id;
    /** 业务编号 */
    private String businessKey;
    /** 抄送已读用户id **/
    private String userId;
    /** 状态 **/
    private String status;
    

    public TaskInfoCopy() {
    }
   
    /** @return 主键. */
    @Id
    @Column(name = "ID", unique = true, nullable = false)
    public Long getId() {
		return Id;
	}
	public void setId(Long id) {
		Id = id;
	}
    /** @return 业务标识. */
    @Column(name = "business_key", length = 100)
    public String getBusinessKey() {
        return this.businessKey;
    }
	/**
     * @param businessKey
     *            业务标识.
     */
    public void setBusinessKey(String businessKey) {
        this.businessKey = businessKey;
    }

    @Column(name = "user_id")
	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}

    
    
    
    
}
