import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:currencygamestock/Providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellBuyPage extends StatefulWidget {
  @override
  _SellBuyPageState createState() => _SellBuyPageState();
}

class _SellBuyPageState extends State<SellBuyPage> {
  UserData _userData = null;
  User _user = null;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<Currency> _allCurrencies = [];
  Currency _selectedCurrency;
  String _currentCurrencyName;

  @override
  void initState() {
    // TODO: implement initState

    _allCurrencies = MoqCurrencies;

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCurrencyName = _dropDownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (Currency cur in _allCurrencies) {
      // if (items.length != 0 && items.any((d) => d.value != cur.name))
      items.add(
          new DropdownMenuItem(value: cur.name, child: new Text(cur.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    _userData = Provider.of<UserData>(context);
    _user = _userData.getUser();

    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffBA8B02), Color(0xff181818)]),
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              child: DropdownButton(
                value: _currentCurrencyName,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            )
          ],
        ),

        //getListview()
      ),
    ));
  }

  void changedDropDownItem(String selectedCurrenyName) {
    print(selectedCurrenyName);
    setState(() {
      _currentCurrencyName = selectedCurrenyName;
    });
  }

  Widget getListview() {
    return Expanded(
        child: _user.wallet.investList.length == 0
            ? Center(
                child: Text("Henüz bir yatırımımınız bulunmamakta."),
              )
            : ListView.builder(
                itemCount: _user.wallet.investList.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(
                      _user.wallet.investList[index].currency.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_user.wallet.investList[index].currencyAmount
                            .toString() +
                        " " +
                        _user.wallet.investList[index].currency.name),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_user.wallet.investList[index]
                                  .getInvestment()
                                  .toStringAsFixed(2) +
                              " ₺"),
                          Text(
                              _user.wallet.investList[index].currency.buyPrice +
                                  " Alış"),
                        ])),
              ));
  }
}
