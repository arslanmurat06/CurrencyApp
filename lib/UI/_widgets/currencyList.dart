import 'package:currencygamestock/Data/moqCurrencyStream.dart';
import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currencyStream.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:currencygamestock/UI/_widgets/currencyList_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyList extends StatefulWidget {
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  var currencies = MoqCurrencies;
  var moqStream = new MoqCurrencyStreamService();

  @override
  Widget build(BuildContext context) {
    StreamBuilder<CurrencyStream> builder = new StreamBuilder(
        stream: moqStream.streamRandomCurency(),
        initialData:
            new CurrencyStream(name: "Test", sellPrice: 7.96, buyPrice: 7.98),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasError)
            return Text("Error happened");
          else if (asyncSnapshot.hasData == null) {
            return Text("no data");
          } else {
            Provider.of<CurrenciesData>(context, listen: false)
                .updateCurrency(asyncSnapshot.data);
            return ListView.builder(
                itemCount: Provider.of<CurrenciesData>(context).getLenght(),
                itemBuilder: (BuildContext context, int index) =>
                    getListitem(context, index));
          }
        });

    return builder;
  }

  CurrencyListItem getListitem(BuildContext context, int index) {
    return CurrencyListItem(
        currency: Provider.of<CurrenciesData>(context).getByIndex(index));
  }
}
