import 'package:currencygamestock/Domain/model/currency.dart';
import 'package:currencygamestock/Domain/model/user.dart';
import 'package:currencygamestock/Domain/model/userInvest.dart';
import 'package:currencygamestock/Domain/model/userWallet.dart';

User getMoqUser() {
  List<UserInvest> userInvestList = [
    new UserInvest(currency: MoqCurrencies[1], currencyAmount: 1000),
    new UserInvest(currency: MoqCurrencies[1], currencyAmount: 1000),
    // new UserInvest(currency: MoqCurrencies[1], currencyAmount: 345),
    // new UserInvest(currency: MoqCurrencies[2], currencyAmount: 37),
    // new UserInvest(currency: MoqCurrencies[2], currencyAmount: 45),
    // new UserInvest(currency: MoqCurrencies[3], currencyAmount: 34),
    // new UserInvest(currency: MoqCurrencies[4], currencyAmount: 345),
    // new UserInvest(currency: MoqCurrencies[5], currencyAmount: 53),
    // new UserInvest(currency: MoqCurrencies[6], currencyAmount: 66),
    // new UserInvest(currency: MoqCurrencies[7], currencyAmount: 34),
    // new UserInvest(currency: MoqCurrencies[8], currencyAmount: 23),
    // new UserInvest(currency: MoqCurrencies[9], currencyAmount: 56),
    // new UserInvest(currency: MoqCurrencies[10], currencyAmount: 77),
    // new UserInvest(currency: MoqCurrencies[11], currencyAmount: 32),
    // new UserInvest(currency: MoqCurrencies[12], currencyAmount: 46),
  ];

  return new User(
      balance: 100000,
      name: "Cem",
      surname: "Zengin",
      wallet: new UserWallet(investList: userInvestList));
}

List<Currency> MoqCurrencies = [
  new Currency(
      name: "XUSD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XRUB/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XEUR/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XGBP/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XDZD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XAOA/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XCD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XCD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XARS/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XAMD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XAWG/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XSHP/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XAUD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XEUR/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XAZN/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XBSD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XBHD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XBDT/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XBBD/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
  new Currency(
      name: "XBYN/TRL",
      description: "Dolar/TL",
      sellPrice: "7.367",
      buyPrice: "7.478"),
];
