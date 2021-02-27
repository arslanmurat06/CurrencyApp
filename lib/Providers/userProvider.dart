import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User _user = null;
  double _allInvest = 0.0;
  String _currentBalance = "";
  double remainedBalance = 0.0;

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

  double _getAllInvest() {
    _allInvest = 0;
    _user.wallet.investList
        .forEach((i) => _calculateAllInvest(i.getInvestment));

    return _allInvest;
  }

  double _calculateAllInvest(double invest) {
    _allInvest = _allInvest + invest;
  }

  double calculateRemainedBalance() {
    remainedBalance = 0.0;
    remainedBalance = _user.balance - _getAllInvest();
    return remainedBalance;
  }

  get getRemainedBalance => calculateRemainedBalance();
}
