package com.fc.service;

import com.fc.mapper.LogMapper;
import com.fc.model.Log;
import com.fc.util.MyUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LogService {

    @Autowired
    private LogMapper logMapper;

    public Map<String, List<Log>> listLogByUserId(Integer sessionUid) {
        List<Log> logList = logMapper.listLogByUserId(sessionUid);
        Map<String, List<Log>> map = new HashMap<>();
        for (Log log : logList) {
            String time = MyUtil.formatDate(log.getMsgTime()).substring(0, 11);
            if (map.get(time) == null) {
                map.put(time, new LinkedList<>());
                map.get(time).add(log);
            } else {
                map.get(time).add(log);
            }
        }
        map = sortByTime(map);
        return map;
    }

    public static Map<String, List<Log>> sortByTime(Map<String, List<Log>> map)
    {
        TreeMap<String, List<Log>> sorted = new TreeMap<>();

        sorted.putAll(map);

        return sorted;
    }
}
