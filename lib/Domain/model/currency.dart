import 'package:flutter/material.dart';

class Currency {
  String name;
  String description;
  String sellPrice;
  String buyPrice;
  bool changed;
  bool increased;
  String percentage;

  Currency(
      {this.name,
      this.description,
      this.sellPrice,
      this.buyPrice,
      this.changed = false,
      this.increased = false,
      this.percentage});
}
