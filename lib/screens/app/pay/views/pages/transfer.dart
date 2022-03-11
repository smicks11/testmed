import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/pay/views/pages/enter_otp.dart';
import 'package:medfest/screens/app/pay/views/pages/scan_code.dart';
import 'package:medfest/utils/colors.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  //NumberFormat  oCcy =  NumberFormat("#,##0.00", "en_US");
  TextEditingController walletController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          "Transfer",
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
                      text: "How much do you want to transfer?",
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
                              fontSize: 64,
                              color: Colors.white.withOpacity(0.8))),
                      Expanded(
                          child: TextField(
                        inputFormatters: [CurrencyTextInputFormatter()],
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
                height: size.height * 0.3,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(curveRadius),
                    topRight: Radius.circular(curveRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CText(
                          text: "Enter receiver's wallet address",
                          color: Colors.black.withOpacity(0.5),
                          size: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0),
                                child: TextFormField(
                                  controller: walletController,
                                  cursorColor: Colors.black.withOpacity(0.5),
                                  style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var result = await Get.to(() => const ScanQR());
                              walletController.text = result ?? "No result";
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: 45,
                                width: 45, 
                                decoration: BoxDecoration(
                                    color: kTextColor.withOpacity(0.1),
                                    borderRadius:
                                        BorderRadius.circular(curveRadius)),
                                child: const Center(
                                    child: Icon(
                                  Entypo.mobile,
                                  color: kBlackColor,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (walletController.text.trim().length > 10) {
                            Get.to(() => EnterOTP());
                          } else {
                            null;
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
