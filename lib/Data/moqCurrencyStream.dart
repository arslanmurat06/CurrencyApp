import 'dart:math';

import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currencyStream.dart';

class MoqCurrencyStreamService {
  Stream<CurrencyStream> streamRandomCurency() async* {
    while (true) {
      var rndCurrencyStream = _randomCurrencyStream();
      await Future.delayed(Duration(milliseconds: 500));
      yield rndCurrencyStream;
    }
  }

  double _generateRandomCurrencyAddtionalValue(
      {double min = 0.01, double max = 0.1}) {
    var randomCurrencyAddition = Random();
    var number = randomCurrencyAddition.nextDouble() * (min - max) + min;
    return number;
  }

  CurrencyStream _randomCurrencyStream() {
    var moqCurrencies = MoqCurrencies;
    var rnd = Random();
    var rndIndex = rnd.nextInt(moqCurrencies.length - 1);

    var additionRate = _generateRandomCurrencyAddtionalValue();
    print("addition:" + additionRate.toString());
    return new CurrencyStream(
        buyPrice: double.parse(moqCurrencies[rndIndex].buyPrice) + additionRate,
        sellPrice:
            double.parse(moqCurrencies[rndIndex].sellPrice) + additionRate,
        name: moqCurrencies[rndIndex].name);
  }
}
