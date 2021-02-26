import 'package:currencygamestock/Providers/userProvider.dart';
import 'package:currencygamestock/UI/_pages/currencyPage.dart';
import 'package:currencygamestock/UI/_pages/homePage.dart';
import 'package:currencygamestock/UI/_pages/walletPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/NavigationRoute.dart';
import 'Providers/currenciesProvider.dart';
import 'UI/_pages/sellBuyPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrenciesData>(
            create: (context) => CurrenciesData()),
        ChangeNotifierProvider<UserData>(create: (context) => UserData()),
      ],
      child: new MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
            accentColor: Colors.redAccent),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          NavigationRoute.HOME_PAGE: (BuildContext context) => new HomePage(),
          NavigationRoute.WALLET_PAGE: (BuildContext context) =>
              new WalletPage(),
          NavigationRoute.SELLBUY_PAGE: (BuildContext context) =>
              new SellBuyPage(),
          NavigationRoute.CURRENCY_PAGE: (BuildContext context) =>
              new CurrencyPage(),
        },
      ),
    );
  }
}
