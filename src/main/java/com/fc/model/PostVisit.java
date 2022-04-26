package com.fc.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@Getter
@Setter
public class PostVisit {
    private int postVisitId;
    private int postId;
    private Date visitedAt;
}
