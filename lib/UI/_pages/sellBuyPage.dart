import 'package:currencygamestock/Data/moqData.dart';
import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:currencygamestock/Providers/userProvider.dart';
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
  User _user = null;
  final sellController = TextEditingController();
  final buyController = TextEditingController();
  String buyText = "0.0";
  String sellText = "0.0";

  @override
  Widget build(BuildContext context) {
    _userData = Provider.of<UserData>(context);
    _user = _userData.getUser();

    print(sellText);

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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Text(currencyName + ": " + currencyPrice + "₺",
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
          onTap: () {},
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
                    child: Text(currencyName + ": " + currencyPrice + "₺",
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
          onTap: () {},
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
                      Text(_userData.remainedBalance.toStringAsFixed(2) + " ₺",
                          style: TextStyle(fontSize: 30)),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Toplam " + widget.currencyName + " Bakiyeniz",
                          style: TextStyle(fontSize: 25)),
                      Text(
                          _userData
                                  .getSpecificGroupedInvest(widget.currencyName)
                                  .currencyAmount
                                  .toStringAsFixed(2) +
                              " " +
                              widget.currencyName,
                          style: TextStyle(fontSize: 30)),
                    ],
                  )));
  }

  onSellTextChange(String number, BuildContext context) {
    var enteredNumber = double.parse(number);
    var currentBalance =
        _userData.getSpecificGroupedInvest(widget.currencyName).currencyAmount;

    if (enteredNumber > currentBalance) {
      _showAlertDialog(context);
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
      _showAlertDialog(context);
      buyController.text = currentBalance.toStringAsFixed(2);
    }

    setState(() {
      buyText = (double.parse(number == "" ? "0.0" : number) /
              double.parse(widget.currencyPrice))
          .toStringAsFixed(3);
    });
  }

  _showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı"),
      content: Text("Bakiyeniz yetersiz"),
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
}
