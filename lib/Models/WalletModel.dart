

class WalletModel {
  WalletModel({
    this.currency,
    this.symbol,
    this.depositFeeNetworks,
    this.withdrawFeeNetworks,
    this.logo,
    this.type,
    this.address,
    this.paymentId,
    this.balanceInWallet,
    this.balanceInOrder,
    this.balanceInWithdraw,
    this.balanceInWalletUsdt,
    this.balanceTotalUsdt,
    this.lastpriceUsdt,
  });

  String? currency;
  String? symbol;
  List<FeeNetwork>? depositFeeNetworks;
  List<FeeNetwork>? withdrawFeeNetworks;
  String? logo;
  String? type;
  String? address;
  String? paymentId;
  String? balanceInWallet;
  String? balanceInOrder;
  String? balanceInWithdraw;
  String? balanceInWalletUsdt;
  String? balanceTotalUsdt;
  var lastpriceUsdt;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    currency: json["currency"],
    symbol: json["symbol"],
    depositFeeNetworks: List<FeeNetwork>.from(json["deposit_fee_networks"].map((x) => FeeNetwork.fromJson(x))),
    withdrawFeeNetworks: List<FeeNetwork>.from(json["withdraw_fee_networks"].map((x) => FeeNetwork.fromJson(x))),
    logo: json["logo"],
    type: json["type"],
    address: json["address"],
    paymentId: json["payment_id"],
    balanceInWallet: json["balance_in_wallet"],
    balanceInOrder: json["balance_in_order"],
    balanceInWithdraw: json["balance_in_withdraw"],
    balanceInWalletUsdt: json["balance_in_wallet_usdt"],
    balanceTotalUsdt: json["balance_total_usdt"],
    lastpriceUsdt: json["lastprice_usdt"],
  );

  static List<WalletModel> listFromJson(List data) {
    print(data);
    return List<WalletModel>.from(data.map((x) => WalletModel.fromJson(x)));
  }


  Map<String, dynamic> toJson() => {
    "currency": currency,
    "symbol": symbol,
    "deposit_fee_networks": List<dynamic>.from(depositFeeNetworks!.map((x) => x.toJson())),
    "withdraw_fee_networks": List<dynamic>.from(withdrawFeeNetworks!.map((x) => x.toJson())),
    "logo": logo,
    "type": type,
    "address": address,
    "payment_id": paymentId,
    "balance_in_wallet": balanceInWallet,
    "balance_in_order": balanceInOrder,
    "balance_in_withdraw": balanceInWithdraw,
    "balance_in_wallet_usdt": balanceInWalletUsdt,
    "balance_total_usdt": balanceTotalUsdt,
    "lastprice_usdt": lastpriceUsdt,
  };
}

class FeeNetwork {
  FeeNetwork({
    this.fee,
    this.percent,
  });

  int? fee;
  bool? percent;

  factory FeeNetwork.fromJson(Map<String, dynamic> json) => FeeNetwork(
    fee: json["fee"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "fee": fee,
    "percent": percent,
  };
}
