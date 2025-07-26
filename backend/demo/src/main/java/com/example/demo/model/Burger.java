package com.example.demo.model;

public class Burger {

    private String type;
    private boolean extraCheese;
    private double price;

    public Burger(String type, boolean extraCheese, double price) {
        this.type = type;
        this.extraCheese = extraCheese;
        this.price = price;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isExtraCheese() {
        return extraCheese;
    }

    public void setExtraCheese(boolean extraCheese) {
        this.extraCheese = extraCheese;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}

