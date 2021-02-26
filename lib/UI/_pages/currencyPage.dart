import 'package:currencygamestock/UI/_pages/sellBuy.dart';
import 'package:currencygamestock/UI/_pages/walletPage.dart';
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
      drawer: _buildCustomDrawer(),
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

  _buildCustomDrawer() {
    return Drawer(
        child: SafeArea(
      child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "GameStock Currency",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey,
              height: 0.5,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildGesture(() {
                        print("Yasal  clicked");
                      }, "Yasal Sözleşme", Icon(Icons.assignment)),
                      _buildGesture(() {
                        print("Bilgilendirme clicked");
                      }, "Bilgilendirme", Icon(Icons.info)),
                      _buildGesture(() {
                        print("Duyurular clicked");
                      }, "Duyurular/Haberler", Icon(Icons.announcement)),
                      _buildGesture(() {
                        print("Scoreboard clicked");
                      }, "Scoreboard", Icon(Icons.score)),
                      _buildGesture(() {
                        print("Hesap kapatma clicked");
                      },
                          "Hesap Kapatma",
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ),
            )
          ])),
    ));
  }

  Widget _buildGesture(Function goToPage, String text, Icon customIcon) {
    return GestureDetector(
      child: ListTile(
          title: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          leading: customIcon),
      onTap: goToPage,
    );
  }
}
