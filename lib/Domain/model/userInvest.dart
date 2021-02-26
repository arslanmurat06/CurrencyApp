import 'package:flutter/material.dart';

import 'currency.dart';

class UserInvest {
  UniqueKey id = UniqueKey();
  Currency currency;
  double currencyAmount;
  UserInvest({this.currency, this.currencyAmount});

  double get getInvestment => double.parse(currency.buyPrice) * currencyAmount;
}
