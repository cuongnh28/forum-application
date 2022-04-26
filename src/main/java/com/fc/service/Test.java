package com.fc.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.logging.SimpleFormatter;

public class Test {

    public static void main(String[] args) throws ParseException {
        double x = 2;
        double y =3;
        double a = x/y*100;
        String incrementUser = String.format("%.2f",a);
        System.out.println(incrementUser);
    }
}
