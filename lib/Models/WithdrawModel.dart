import 'dart:convert';

WithdrawModel withdrawModelFromJson(String str) =>
    WithdrawModel.fromJson(json.decode(str));

String withdrawModelToJson(WithdrawModel data) => json.encode(data.toJson());

class WithdrawModel {
  WithdrawModel({
    required this.withdrawalId,
    required this.status,
    required this.logo,
    required this.txn,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.explorer,
    required this.symbol,
    required this.address,
    required this.rejectedReason,
    required this.paymentId,
    required this.confirms,
    required this.createdAt,
  });

  final String withdrawalId;
  final String status;
  final String logo;
  final dynamic txn;
  final String amount;
  final String fee;
  final String currency;
  final dynamic explorer;
  final String symbol;
  final String address;
  final String rejectedReason;
  final dynamic paymentId;
  final int confirms;
  final DateTime createdAt;

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
        withdrawalId: json["withdrawal_id"],
        status: json["status"],
        logo: json["logo"],
        txn: json["txn"],
        amount: json["amount"],
        fee: json["fee"],
        currency: json["currency"],
        explorer: json["explorer"],
        symbol: json["symbol"],
        address: json["address"],
        rejectedReason: json["rejected_reason"],
        paymentId: json["payment_id"],
        confirms: json["confirms"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "withdrawal_id": withdrawalId,
        "status": status,
        "logo": logo,
        "txn": txn,
        "amount": amount,
        "fee": fee,
        "currency": currency,
        "explorer": explorer,
        "symbol": symbol,
        "address": address,
        "rejected_reason": rejectedReason,
        "payment_id": paymentId,
        "confirms": confirms,
        "created_at": createdAt.toIso8601String(),
      };

  static List<WithdrawModel> listFromJson(List data) {
    print(data);
    return List<WithdrawModel>.from(data.map((x) => WithdrawModel.fromJson(x)));
  }
}
