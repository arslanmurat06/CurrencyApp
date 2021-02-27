import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/currencyStream.dart';
import 'package:flutter/cupertino.dart';

class CurrenciesData extends ChangeNotifier {
  List<Currency> _currencies = MoqCurrencies;

  void setList(List<Currency> list) {
    this._currencies = list;
    notifyListeners();
  }

  int getCurrencyListLenght() {
    return _currencies.length;
  }

  Currency getCurrecyByName(String curencyName) {
    return _currencies.firstWhere((c) => c.name == curencyName);
  }

  void updateCurrency(CurrencyStream stream) {
    var currency = _currencies.firstWhere((c) => c.name == stream.name,
        orElse: () => null);

    if (currency == null) return;

    currency.buyPrice = stream.buyPrice.toStringAsFixed(4);
    currency.sellPrice = stream.sellPrice.toStringAsFixed(4);
    currency.increased =
        _calculatePercentage(double.parse(currency.buyPrice), stream.buyPrice) <
                0
            ? false
            : true;
    currency.changed = true;
  }

  double _calculatePercentage(double oldValue, double newValue) {
    return (newValue - oldValue) / (oldValue) * 100;
  }

  Currency getByIndex(int index) => _currencies[index];
  int getLenght() => _currencies.length;
  get getCurrencies => _currencies;
}
