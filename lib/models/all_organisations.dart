// To parse this JSON data, do
//
//     final allOrganisations = allOrganisationsFromJson(jsonString);

import 'dart:convert';

List<AllOrganisations> allOrganisationsFromJson(String str) => List<AllOrganisations>.from(json.decode(str).map((x) => AllOrganisations.fromJson(x)));

String allOrganisationsToJson(List<AllOrganisations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllOrganisations {
    AllOrganisations({
        required this.uid,
        required this.fullName,
        required this.email,
        required this.phoneNo,
        required this.emailVerification,
        required this.bvn,
        required this.nin,
        required this.tag,
        required this.accountType,
        required this.orgType,
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
    String orgType;
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

    factory AllOrganisations.fromJson(Map<String, dynamic> json) => AllOrganisations(
        uid: json["uid"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        emailVerification: json["email_verification"],
        bvn: json["bvn"],
        nin: json["nin"],
        tag: json["tag"],
        accountType: json["account_type"],
        orgType: json["org_type"],
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
        "org_type": orgType,
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
