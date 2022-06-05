import 'dart:convert';

DepositModel depositModelFromJson(String str) => DepositModel.fromJson(json.decode(str));

String depositModelToJson(DepositModel data) => json.encode(data.toJson());

class DepositModel {
  DepositModel({
    required this.depositId,
    required this.status,
    required this.txn,
    required this.logo,
    required this.explorer,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.symbol,
    required this.address,
    required this.paymentId,
    required this.confirms,
    required this.createdAt,
  });

  final String depositId;
  final String status;
  final String txn;
  final String logo;
  final String explorer;
  final String amount;
  final dynamic fee;
  final String currency;
  final String symbol;
  final String address;
  final dynamic paymentId;
  final int confirms;
  final DateTime createdAt;

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
    depositId: json["deposit_id"],
    status: json["status"],
    txn: json["txn"],
    logo: json["logo"],
    explorer: json["explorer"],
    amount: json["amount"],
    fee: json["fee"],
    currency: json["currency"],
    symbol: json["symbol"],
    address: json["address"],
    paymentId: json["payment_id"],
    confirms: json["confirms"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "deposit_id": depositId,
    "status": status,
    "txn": txn,
    "logo": logo,
    "explorer": explorer,
    "amount": amount,
    "fee": fee,
    "currency": currency,
    "symbol": symbol,
    "address": address,
    "payment_id": paymentId,
    "confirms": confirms,
    "created_at": createdAt.toIso8601String(),
  };
  static List<DepositModel> listFromJson(List data) {
    print(data);
    return List<DepositModel>.from(data.map((x) => DepositModel.fromJson(x)));
  }
}
