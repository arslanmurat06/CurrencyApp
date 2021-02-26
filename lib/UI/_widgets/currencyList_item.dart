import 'package:currencygamestock/Data/moqCurrencyStream.dart';
import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:flutter/material.dart';

class CurrencyListItem extends StatefulWidget {
  final Currency currency;

  const CurrencyListItem({Key key, this.currency}) : super(key: key);
  @override
  _CurrencyListItemState createState() => _CurrencyListItemState();
}

class _CurrencyListItemState extends State<CurrencyListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    setState(() {
      this.color = (widget.currency.changed != false)
          ? (widget.currency.increased ? Colors.green : Colors.red)
          : Colors.transparent;
    });

    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child:
                    Text(widget.currency.name, style: TextStyle(fontSize: 14)),
              ),
              Expanded(
                flex: 2,
                child: !widget.currency.increased
                    ? Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                      ),
              ),
              Expanded(
                flex: 3,
                child:
                    _getAnimatedContainer(widget.currency.buyPrice.toString()),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child:
                    _getAnimatedContainer(widget.currency.sellPrice.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAnimatedContainer(String string) {
    return AnimatedContainer(
      onEnd: () {
        setState(() {
          this.color = Colors.blue;
          widget.currency.changed = false;
        });
      },
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(string, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
