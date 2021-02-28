import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:currencygamestock/Providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletDetailPage extends StatefulWidget {
  final String currencyName;

  const WalletDetailPage({Key key, @required this.currencyName})
      : super(key: key);
  @override
  _WalletDetailPageState createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  List<UserInvest> _userInvest = [];
  @override
  Widget build(BuildContext context) {
    _userInvest = Provider.of<UserData>(context)
        .getSpecificInvestList(widget.currencyName);

    //add If needed
    // var liveCurrency = Provider.of<CurrenciesData>(context)
    //     .getCurrecyByName(widget.currencyName);
    // var contHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currencyName + " İşlemleri"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Column(children: [
        //getContainer(contHeight, liveCurrency), //ask if needed
        Expanded(child: _getListView()),
      ]),
    );
  }

  Widget getContainer(double screenHeight, Currency liveCurrency) {
    return Container(
      height: screenHeight / 2.5,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff0F1C28), Color(0xff0F1C28)]),
        color: Colors.orange,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Center(
                child: Text(
                    widget.currencyName + " -> " + liveCurrency.sellPrice + "₺",
                    style: TextStyle(fontSize: 30))),
          ),
          Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Toplam Bakiyeniz:",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "2" + " ₺",
                      style: TextStyle(fontSize: 35),
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kalan Bakiyeniz:",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "3" + " ₺",
                      style: TextStyle(fontSize: 35),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _getListView() {
    return ListView.builder(
      itemCount: _userInvest.length,
      itemBuilder: (context, index) => ListTile(
          title: Text(
            _userInvest[index].currency.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(_userInvest[index].currencyAmount.toStringAsFixed(3) +
              " " +
              _userInvest[index].currency.name),
          trailing:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(_userInvest[index].getInvestment().toStringAsFixed(2) + " ₺"),
            Text(_userInvest[index].currency.buyPrice + " Alış"),
          ])),
    );
  }
}
