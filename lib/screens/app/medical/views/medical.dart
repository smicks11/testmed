import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/medical/views/components/medical_grid.dart';
import 'package:medfest/utils/colors.dart';

class Medicals extends StatelessWidget {
  const Medicals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    margin: EdgeInsets.only(top: size.height * 0.18),
                    padding: const EdgeInsets.all(18),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(curveRadius),
                        topRight: Radius.circular(curveRadius),
                      ),
                      color: kBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        MedicalGrid(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.60,
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    // left: 15,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.08),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CText(
                              text: 'Medical',
                              fontWeight: FontWeight.w600,
                              size: 26,
                              letterSpacing: 1.0,
                              color: kPrimaryColor,
                              bold: true,
                            ),
                            SizedBox(height: size.height * 0.01),
                            const CText(
                              text:
                                  'Access MEDFESTCARE free healthcare service here',
                              fontWeight: FontWeight.w400,
                              size: 12,
                              letterSpacing: 0.5,
                              color: kBlackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;

  const ImageCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }
}
