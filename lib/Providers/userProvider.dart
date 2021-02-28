import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:currencygamestock/Providers/currenciesProvider.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User _user;
  double _allInvest = 0.0;
  double remainedBalance = 0.0;
  List<UserInvest> _groupedUserInvest;

  setUser(User user) {
    _user = user;
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
    return this._user;
  }

  double _getAllInvest() {
    _allInvest = 0;
    _user.wallet.investList
        .forEach((i) => _calculateAllInvest(i.getInvestment()));

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

  List<UserInvest> getGroupedInvest() {
    _groupedUserInvest = [];

    var groupedInvests = groupBy(
        _user.wallet.investList, (i) => (i as UserInvest).currency.name);

    groupedInvests.forEach((k, v) => _groupallInvest(k, v, _groupedUserInvest));

    return _groupedUserInvest;
  }

  List<UserInvest> getSpecificInvestList(String currencyName) {
    return _user.wallet.investList
        .where((i) => i.currency.name == currencyName)
        .toList();
  }

  UserInvest getSpecificGroupedInvest(String currencyName) {
    var a =
        _groupedUserInvest.firstWhere((i) => i.currency.name == currencyName);
    print("totalInvest" +
        a.totalInvest.toStringAsFixed(3) +
        " adı:" +
        a.currency.name);
    return a;
  }

  _groupallInvest(String k, List<UserInvest> v, List<UserInvest> _investList) {
    String name = "";
    double currencyAmount = 0.0;
    double totalInvest = 0.0;

    v.forEach((i) {
      currencyAmount += i.currencyAmount;
      totalInvest += i.getInvestment();
    });

    var currency = new Currency(name: k);
    var inves =
        new UserInvest(currency: currency, currencyAmount: currencyAmount);
    inves.totalInvest = totalInvest;
    _investList.add(inves);
  }
}

Map<Y, List<T>> groupBy<T, Y>(Iterable<T> itr, Y Function(T) fn) {
  return Map.fromIterable(itr.map(fn).toSet(),
      value: (i) => itr.where((v) => fn(v) == i).toList());
}
