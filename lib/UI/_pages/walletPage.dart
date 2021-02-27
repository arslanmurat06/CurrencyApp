import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  UserData _userData = null;
  User _user = null;

  @override
  Widget build(BuildContext context) {
    _userData = Provider.of<UserData>(context);
    _user = _userData.getUser();

    var contHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          Container(
            height: contHeight / 3,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xfff12711), Color(0xff5af19)]),
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                        _userData.getUser().name +
                            " " +
                            _userData.getUser().surname,
                        style: TextStyle(fontSize: 30)),
                  ),
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
                            _user.balance.toStringAsFixed(2) + " ₺",
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
                            _userData.getRemainedBalance.toStringAsFixed(2) +
                                " ₺",
                            style: TextStyle(fontSize: 35),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
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
                          subtitle: Text(_user
                                  .wallet.investList[index].currencyAmount
                                  .toString() +
                              " " +
                              _user.wallet.investList[index].currency.name),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_user
                                        .wallet.investList[index].getInvestment
                                        .toStringAsFixed(2) +
                                    " ₺"),
                                Text(_user.wallet.investList[index].currency
                                        .buyPrice +
                                    " Alış"),
                              ])),
                    ))
        ],
      ),
    ));
  }
}
