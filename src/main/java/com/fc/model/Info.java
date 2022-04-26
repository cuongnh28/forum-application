package com.fc.model;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Info {

    private Integer infoId;
    private String requestUrl;
    private String contextPath;
    private String remoteAddr;
    private Date access_time;

    @Override
    public String toString() {
        return "Info{" +
                "infoId=" + infoId +
                ", requestUrl='" + requestUrl + '\'' +
                ", contextPath='" + contextPath + '\'' +
                ", remoteAddr='" + remoteAddr + '\'' +
                ", access_time='" + access_time + '\'' +
                '}';
    }
}
