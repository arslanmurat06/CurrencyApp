import 'package:currencygamestock/Domain/model/userWallet.dart';

class User {
  String name;
  String surname;
  double balance;
  UserWallet wallet;

  User({this.name, this.surname, this.balance, this.wallet});
}
