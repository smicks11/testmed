// To parse this JSON data, do
//
//     final walletInfo = walletInfoFromJson(jsonString);

import 'dart:convert';

WalletInfo walletInfoFromJson(String str) =>
    WalletInfo.fromJson(json.decode(str));

String walletInfoToJson(WalletInfo data) => json.encode(data.toJson());

class WalletInfo {
  WalletInfo({
    required this.uid,
    required this.email,
    required this.walletAddress,
    required this.fullName,
    required this.totalBalance,
    required this.rateOfSpending,
  });

  String uid;
  String email;
  String walletAddress;
  String fullName;
  double totalBalance;
  String rateOfSpending;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        uid: json["uid"],
        email: json["email"],
        walletAddress: json["wallet_address"],
        fullName: json["full_name"],
        totalBalance: json["total_balance"],
        rateOfSpending: json["rate_of_spending"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "wallet_address": walletAddress,
        "full_name": fullName,
        "total_balance": totalBalance,
        "rate_of_spending": rateOfSpending,
      };
}
