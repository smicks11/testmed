import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/screens/app/pay/controller/payment_controller.dart';
import 'package:medfest/utils/colors.dart';

class Withdraw extends StatefulWidget {
  Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  List<String> banks = [
    'Access Bank Plc',
    'Fidelity Bank Plc',
    'First City Monument Bank Limited',
    'First Bank of Nigeria Limited',
    'Guaranty Trust Holding Company Plc',
    'Union Bank of Nigeria Plc',
    'United Bank for Africa Plc',
    'Zenith Bank Plc',
  ];
  String? selectedBank;
  TextEditingController requestAmountController = TextEditingController();

  TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var paymentController = Get.find<PaymentController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Withdraw",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          color: kPrimaryColor,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                      text: "How much do you want to withdraw?",
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w600,
                      size: 18,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text("₦",
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600,
                              fontSize: 50,
                              color: Colors.white.withOpacity(0.8))),
                      Expanded(
                          child: TextFormField(
                        controller: requestAmountController,
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Container(
                height: size.height * 0.6,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CText(
                          text: "Select Bank to withdraw to",
                          color: kTextColor.withOpacity(0.5),
                          size: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 2.0),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: const CText(
                              text: 'Please choose a Bank',
                              letterSpacing: 1,
                            ), // Not necessary for Option 1
                            value: selectedBank,
                            onChanged: (newValue) {
                              selectedBank = newValue.toString();
                              setState(() {});
                            },
                            items: banks.map((location) {
                              return DropdownMenuItem(
                                child: Text(
                                  location,
                                  style: TextStyle(
                                    color: kTextColor.withOpacity(0.5),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CText(
                          text: "Enter Bank Account Number",
                          color: kTextColor.withOpacity(0.5),
                          size: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: TextFormField(
                            controller: accountNumberController,
                            keyboardType: TextInputType.number,
                            cursorColor: kTextColor.withOpacity(0.5),
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            // maxLength: 11,

                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            // TextSpan(
                            //   text: "Click ",
                            // ),
                            const WidgetSpan(
                              child: Icon(Entypo.light_bulb, size: 30),
                            ),
                            TextSpan(
                              text:
                                  " Withdrawal can take about 24 hours to complete",
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: kTextColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (requestAmountController.text.isEmpty) {
                            cToast(msg: "Please enter an amount to withdraw",color: Colors.red);
                          } else if (accountNumberController.text.length < 10) {
                            cToast(
                                msg:
                                    "Account number must be at least 10 characters long",color: Colors.red);
                          } else if (selectedBank == null) {
                            cToast(msg: "Please select a bank",color: Colors.red);
                          } else {
                            //withdraw
                            paymentController.withdraw(
                                selectedBank: selectedBank!,
                                amount: requestAmountController.text,
                                accountNumber: accountNumberController.text);
                          }
                        },
                        child: Container(
                          height: 60,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: CText(
                              text: "Proceed",
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600,
                              size: 20,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
