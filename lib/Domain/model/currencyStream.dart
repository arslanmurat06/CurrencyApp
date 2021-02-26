import 'package:flutter/material.dart';

class CurrencyStream {
  final String name;
  final double sellPrice;
  final double buyPrice;

  const CurrencyStream({
    @required this.name,
    @required this.sellPrice,
    @required this.buyPrice,
  })  : assert(name != null),
        assert(sellPrice != null),
        assert(buyPrice != null);
}
