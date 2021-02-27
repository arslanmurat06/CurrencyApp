import 'package:currencygamestock/UI/_widgets/currencyList.dart';
import 'package:flutter/material.dart';

class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _buildHeader(),
        Expanded(flex: 11, child: CurrencyList())
      ]),
    );
  }

  Widget _buildHeader() {
    return Expanded(
        flex: 1,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child:
                    Center(child: Text("Kur", style: TextStyle(fontSize: 18)))),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
                flex: 3,
                child: Center(
                    child: Text(
                  "Alış",
                  style: TextStyle(fontSize: 18),
                ))),
            Expanded(
                flex: 3,
                child: Center(
                    child: Text("Satış", style: TextStyle(fontSize: 18))))
          ],
        ));
  }
}
