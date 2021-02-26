import 'package:currencygamestock/UI/_pages/currencyPage.dart';
import 'package:currencygamestock/UI/_pages/sellBuy.dart';
import 'package:currencygamestock/UI/_pages/walletPage.dart';
import 'package:currencygamestock/UI/_widgets/currencyList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();
  final List<Widget> _pages = [CurrencyPage(), WalletPage(), SellBuyPage()];

  final List<String> _selectedPageTitle = [
    "GameStock Currency",
    "Cüzdanım",
    "Al/Sat",
  ];
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: _buildBottomNavigation(context),
      drawer: _buildCustomDrawer(),
    );
  }

  Theme _buildBottomNavigation(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.green[900],
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.yellow))),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue[800],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on, size: 30, color: Colors.white),
              label: "Kurlar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet_giftcard_outlined,
                  size: 30, color: Colors.white),
              label: "Cüzdan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.clean_hands_outlined,
                  size: 30, color: Colors.white),
              label: "Al/Sat"),
        ],
        onTap: (index) {
          print(index);
          _selectedIndex = index;
          _selectPage(index);
        },
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.black12,
      title: Text(_selectedPageTitle[_selectedPageIndex]),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.search,
      //       size: 25,
      //     ),
      //     onPressed: () {},
      //   ),
      // ],
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