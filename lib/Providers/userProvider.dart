import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User _user = null;

  setUser(User user) {
    _user = user;
    print("User added" + _user.name);
  }

  addUserWallet(UserInvest invest) {
    _user.wallet.investList.add(invest);
    notifyListeners();
  }

  removeUserWallet(UserInvest invest) {
    _user.wallet.investList.removeWhere((i) => i.id == invest.id);
    notifyListeners();
  }

  User getUser() {
    print("user called" + _user.name);
    return this._user;
  }
}
