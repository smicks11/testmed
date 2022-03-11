// To parse this JSON data, do
//
//     final transactionHistory = transactionHistoryFromJson(jsonString);

import 'dart:convert';

List<TransactionHistory> transactionHistoryFromJson(String str) =>
    List<TransactionHistory>.from(
        json.decode(str).map((x) => TransactionHistory.fromJson(x)));

String transactionHistoryToJson(List<TransactionHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionHistory {
  TransactionHistory({
    required this.id,
    required this.uid,
    required this.walletAddress,
    required this.amount,
    required this.date,
    required this.cardType,
    required this.bank,
    required this.last4,
    required this.transactionType,
  });

  String id;
  String uid;
  String walletAddress;
  String amount;
  DateTime date;
  String cardType;
  String bank;
  String last4;
  String transactionType;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["id"],
        uid: json["uid"],
        walletAddress: json["wallet_address"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        cardType: json["card_type"] ?? "",
        bank: json["bank"] ?? "",
        last4: json["last4"] ?? "",
        transactionType: json["transaction_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "wallet_address": walletAddress,
        "amount": amount,
        "date": date.toIso8601String(),
        "card_type": cardType,
        "bank": bank,
        "last4": last4,
        "transaction_type": transactionType,
      };
}
