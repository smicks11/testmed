// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.uid,
        required this.fullName,
        required this.email,
        required this.phoneNo,
        required this.emailVerification,
        required this.bvn,
        required this.nin,
        required this.tag,
        required this.accountType,
        required this.walletAddress,
        required this.fullyVerified,
        required this.dateRegistered,
        required this.accessdate,
        required this.location,
        required this.address,
        required this.referralCode,
        required this.subscriberStatus,
        required this.badge,
        required this.point,
    });

    String uid;
    String fullName;
    String email;
    String phoneNo;
    String emailVerification;
    dynamic bvn;
    dynamic nin;
    String tag;
    String accountType;
    String walletAddress;
    String fullyVerified;
    DateTime dateRegistered;
    DateTime accessdate;
    dynamic location;
    String address;
    String referralCode;
    String subscriberStatus;
    dynamic badge;
    int point;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        emailVerification: json["email_verification"],
        bvn: json["bvn"],
        nin: json["nin"],
        tag: json["tag"],
        accountType: json["account_type"],
        walletAddress: json["wallet_address"],
        fullyVerified: json["fully_verified"],
        dateRegistered: DateTime.parse(json["date_registered"]),
        accessdate: DateTime.parse(json["accessdate"]),
        location: json["location"],
        address: json["address"],
        referralCode: json["referral_code"],
        subscriberStatus: json["subscriber_status"],
        badge: json["badge"],
        point: json["point"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "full_name": fullName,
        "email": email,
        "phone_no": phoneNo,
        "email_verification": emailVerification,
        "bvn": bvn,
        "nin": nin,
        "tag": tag,
        "account_type": accountType,
        "wallet_address": walletAddress,
        "fully_verified": fullyVerified,
        "date_registered": dateRegistered.toIso8601String(),
        "accessdate": accessdate.toIso8601String(),
        "location": location,
        "address": address,
        "referral_code": referralCode,
        "subscriber_status": subscriberStatus,
        "badge": badge,
        "point": point,
    };
}
