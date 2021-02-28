import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:currencygamestock/Providers/userProvider.dart';
import 'package:currencygamestock/UI/_pages/currencyPage.dart';
import 'package:currencygamestock/UI/_pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellBuyPage extends StatefulWidget {
  final String currencyPrice;
  final String currencyName;
  final bool isSell;

  const SellBuyPage(
      {Key key, this.currencyPrice, this.currencyName, this.isSell})
      : super(key: key);
  @override
  _SellBuyPageState createState() => _SellBuyPageState();
}

class _SellBuyPageState extends State<SellBuyPage> {
  UserData _userData = null;
  CurrenciesData _currenciesData = null;
  User _user = null;
  final sellController = TextEditingController();
  final buyController = TextEditingController();
  String buyText = "0.0";
  String sellText = "0.0";
  bool willProcessContinue = false;
  bool willBeAbsorbed = false;

  @override
  Widget build(BuildContext context) {
    _userData = Provider.of<UserData>(context);
    _currenciesData = Provider.of<CurrenciesData>(context);
    _user = _userData.getUser();
    _userData.getGroupedInvest();

    willBeAbsorbed =
        _userData.getSpecificGroupedInvest(widget.currencyName) == null;
    var contHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isSell
              ? ("Sat " + widget.currencyName)
              : "Al " + widget.currencyName),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(children: [
              _buildeBalanceContainer(contHeight),
              SizedBox(
                height: 20,
              ),
              widget.isSell
                  ? _buildSellWidget(widget.currencyName, widget.currencyPrice)
                  : _buildBuyWidget(widget.currencyName, widget.currencyPrice),
            ]),
          ),
        ));
  }

  Widget _buildSellWidget(String currencyName, String currencyPrice) {
    return AbsorbPointer(
      absorbing: willBeAbsorbed,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      child: Text(currencyName + ": " + currencyPrice + " ₺",
                          style: TextStyle(fontSize: 18))))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    onChanged: (text) {
                      onSellTextChange(text, context);
                    },
                    controller: sellController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      labelText: 'Satılacak Adet',
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  margin: EdgeInsets.all(20),
                  child: Text(sellText + " ₺", style: TextStyle(fontSize: 18)),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              _setSellProcess(context);
            },
            child: Container(
              width: 240,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: Text('Sat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyWidget(String currencyName, String currencyPrice) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(currencyName + ": " + currencyPrice + " ₺",
                        style: TextStyle(fontSize: 18))))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (text) {
                    onBuyTextChanged(text, context);
                  },
                  controller: buyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    labelText: 'Alınacak Miktar (₺)',
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                margin: EdgeInsets.all(20),
                child: Text(
                  buyText + " " + widget.currencyName,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            _setBuyProcess(context);
          },
          child: Container(
            width: 240,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
            child: Text('Al'),
          ),
        ),
      ],
    );
  }

  _setBuyProcess(BuildContext context) {
    var currency = _currenciesData.getCurrecyByName(widget.currencyName);
    var currencyAmount =
        double.parse(buyController.text) / double.parse(widget.currencyPrice);
    var invest =
        new UserInvest(currency: currency, currencyAmount: currencyAmount);

    // _showProcessDialog(
    //     context,
    //     "${currency.name}'den  $currencyAmount ₺ 'lik alım yapılacaktır. Onaylıyor musunuz?",
    _addWallet(invest);
    _showAlertDialog(
        context, "İşlemi başarılı bir şekilde gerçekleşti.", Colors.green);
  }

  _addWallet(UserInvest invest) {
    _userData.addUserWallet(invest);
  }

  _setSellProcess(BuildContext context) {
    var currency = _currenciesData.getCurrecyByName(widget.currencyName);
    var currencyAmount = double.parse(sellController.text);
    var invest =
        new UserInvest(currency: currency, currencyAmount: currencyAmount);
    _removeWallet(invest);
    _showAlertDialog(context, "Satım işlemi başarılı bir şekilde gerçekleşti.",
        Colors.green);
  }

  _removeWallet(UserInvest invest) {
    _userData.removeUserWallet(invest);
  }

  Widget _buildeBalanceContainer(double screenHeight) {
    return Container(
        height: screenHeight / 3,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffBA8B02), Color(0xff181818)]),
          color: Colors.orange,
        ),
        child: Container(
            alignment: Alignment.center,
            child: !widget.isSell
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Kullanılabilir Bakiyeniz: ",
                          style: TextStyle(fontSize: 25)),
                      Text(
                          _userData.getRemainedBalance.toStringAsFixed(2) +
                              " ₺",
                          style: TextStyle(fontSize: 30)),
                    ],
                  )
                : _userData.getSpecificGroupedInvest(widget.currencyName) !=
                        null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Toplam " + widget.currencyName + " Bakiyeniz",
                              style: TextStyle(fontSize: 25)),
                          Text(
                              _userData
                                      .getSpecificGroupedInvest(
                                          widget.currencyName)
                                      .currencyAmount
                                      .toStringAsFixed(2) +
                                  " " +
                                  widget.currencyName,
                              style: TextStyle(fontSize: 30)),
                        ],
                      )
                    : Text("Henüz bakiyeniz bulunmamaktadır",
                        style: TextStyle(fontSize: 15))));
  }

  onSellTextChange(String number, BuildContext context) {
    var enteredNumber = double.parse(number);
    var currentBalance =
        _userData.getSpecificGroupedInvest(widget.currencyName).currencyAmount;

    if (enteredNumber > currentBalance) {
      _showAlertDialog(context, "Bakiyeniz yetersiz.", Colors.red);
      sellController.text = currentBalance.toStringAsFixed(2);
    }
    setState(() {
      sellText = (double.parse(number == "" ? "0.0" : number) *
              double.parse(widget.currencyPrice))
          .toStringAsFixed(3);
    });
  }

  onBuyTextChanged(String number, BuildContext context) {
    var enteredNumber = double.parse(number);
    var currentBalance = _userData.remainedBalance;

    if (enteredNumber > currentBalance) {
      _showAlertDialog(context, "Bakiyeniz yetersiz", Colors.red);
      buyController.text = currentBalance.toStringAsFixed(2);
    }

    setState(() {
      buyText = (double.parse(number == "" ? "0.0" : number) /
              double.parse(widget.currencyPrice))
          .toStringAsFixed(3);
    });
  }

  _showAlertDialog(BuildContext contex, String message, Color backgroundColor) {
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showProcessDialog(BuildContext contex, String message, VoidCallback func) {
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        func.call();
        _showAlertDialog(
            context, "İşlemi başarılı bir şekilde gerçekleşti.", Colors.green);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("İptal"),
      onPressed: () {
        _showAlertDialog(context, "İşlem iptal edildi", Colors.red);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(message),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
