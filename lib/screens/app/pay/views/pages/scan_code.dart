import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/utils/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool cameraPaused = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.08),
                child: Column(
                  children: [
                    const CText(
                      text: 'Scan Wallet Address',
                      fontWeight: FontWeight.w600,
                      size: 26,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: size.height * 0.03),
                    const CText(
                      text: 'Ensure the Barcode is within the box below',
                      fontWeight: FontWeight.w400,
                      size: 15,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.7),
                  child: cameraPaused == true
                      ? Column(
                          children: [
                            const CText(
                              text: 'Scan Completed',
                              fontWeight: FontWeight.w600,
                              size: 26,
                              letterSpacing: 1.0,
                              color: kWhiteColor,
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      handleCode();
                                    },
                                    icon: const Icon(Icons.done,
                                        color: kWhiteColor, size: 40)),
                                const SizedBox(width: 40),
                                IconButton(
                                    onPressed: () {
                                      controller!.resumeCamera();
                                      cameraPaused = false;
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.refresh,
                                        color: kWhiteColor, size: 40)),
                              ],
                            )
                          ],
                        )
                      : const SizedBox()),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: kPrimaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      setState(() {});
      Timer(const Duration(seconds: 1), () {
        // Navigator.pop(context, result!.code.toString());
        setState(() {
          result = scanData;

          cameraPaused = true;
        });
      });
      //  Future.delayed(const Duration(seconds: 2), () => {});
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  handleCode() {
    try {
      if (mounted) {
        if (result != null) {
          Timer(const Duration(seconds: 1), () {
            Navigator.pop(context, result!.code.toString());
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
