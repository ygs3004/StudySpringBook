package org.zerock.domain;

import lombok.Data;

import java.io.Serializable;

@Data
public class AuthVO implements Serializable {

    private String userid;
    private String auth;

}