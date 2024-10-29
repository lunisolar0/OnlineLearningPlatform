package com.example.common.enums;

/**
 * @author : Shiranui
 * @date : $ $
 */
public enum RecommendEnum {
    YES("是"),
    NO("否"),
    ;
    public String status;
    RecommendEnum(String status) {
        this.status=status;
    }
}
