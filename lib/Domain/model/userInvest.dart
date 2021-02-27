import 'package:flutter/material.dart';

import 'currency.dart';

class UserInvest {
  UniqueKey id = UniqueKey();
  Currency currency;
  double currencyAmount;
  double totalInvest = 0.0;
  UserInvest({this.currency, this.currencyAmount});

  double getInvestment() {
    if (totalInvest != 0) return totalInvest;
    return (double.parse(currency.buyPrice) * currencyAmount);
  }
}
