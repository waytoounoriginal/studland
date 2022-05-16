import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studland/colors.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> with TickerProviderStateMixin {

  List colors = [];

  List<CopCard> coupons = [
    CopCard(color: Colors.green, title: 'STARBUCKS', subtitle: '20% OFF!', qrCode: "1234",),
    CopCard(color: Colors.red, title: 'STARBUCKS', subtitle: '20% OFF!', qrCode: "1234"),
    CopCard(color: Colors.blue, title: 'Discord', subtitle: '20% OFF!', qrCode: "1234"),

  ];

  Color contColor = Colors.white;
  double contHeight = 300;

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }


  var title, description, image, dImage, validity;

  void revealQrCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          title: Text("QR Code"),
          content: Container(
            height: 300,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                  child: QrImage(
                    data: "1234",
                    version: QrVersions.auto,
                  ),
                ),
                Text("1234"),
              ],
            ),
          ),
        );
      }
    );
  }



  @override
  void initState() {
    contColor = Color.alphaBlend(coupons[0].color, Colors.white).withOpacity(0.25);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text('Coupons', style: TextStyle(color: Palette.raisinBlack)),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_rounded, color: Palette.raisinBlack,),
            onPressed: () async {
              PermissionStatus status = await _getCameraPermission();

              //Push the QR Code Scanner
              if(status.isGranted){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScanPage(lista: coupons,)),
                );
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
                const SizedBox(height: 75,),
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.65),
                        Colors.white,
                        Colors.white,
                        Colors.white.withOpacity(0.65),
                        Colors.white.withOpacity(0.5)
                      ],
                      stops: [
                        0, 0.1, 0.24, 0.75, 0.9, 1,
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: CarouselSlider(
                    items: coupons,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.5,
                      aspectRatio: 2,
                      viewportFraction: 0.5,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,

                      onPageChanged: (index, reason) async {
                        setState(() {
                          contHeight = 0;

                        });
                        await Future.delayed(Duration(milliseconds: 500));
                        setState(() {
                          contColor = coupons[index].color.withOpacity(0.25);
                        });
                        await Future.delayed(Duration(milliseconds: 500));
                        setState(() {
                          contHeight = 300;
                        });

                      },
                    ),
                  ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
                height: contHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.alphaBlend(contColor, Colors.white),
                        contColor
                      ],
                      stops: [
                        0, 1
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color.alphaBlend(contColor, Colors.black).withOpacity(0.25),
                          blurRadius: 40,
                          offset: Offset(10, 20)
                      ),
                      BoxShadow(
                          color: Color.alphaBlend(contColor, Colors.white).withOpacity(1),
                          blurRadius: 40,
                          offset: Offset(-20, -10)
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            image != null ? Image.network(image, height: 100, width: 100,) : Container(),
                            const SizedBox(width: 10,),
                            Text(
                              'Coupon Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Valid between ${validity.toString()}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.5)
                          ),
                        ),
                        const SizedBox(height: 25,),
                        SizedBox(
                          height: 150,
                          child: dImage != null
                              ? Image.network(dImage, height: 100, width: 100,)
                              : Text('description', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(onPressed: () {
                              revealQrCode();
                            }, icon: Icon(Icons.qr_code_rounded, color: Colors.white,), label: Text(
                              'Reveal QR Code',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),


          ]
        ),
      ),
    );
  }
}

class CopCard extends StatelessWidget {
  final Color color;
  final String title, subtitle;
  final String? image;
  final String? descrImg;
  final String? qrCode;
  const CopCard({Key? key, required this.color, required this.title, required this.subtitle, this.image, this.descrImg, required this.qrCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      height: 200,
      backgroundColor: color,
      firstChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            image != null ? Image.network(image!, height: 100,) : Container(),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              subtitle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      secondChild: SizedBox(),

    );
  }
}

class QRScanPage extends StatefulWidget {
  List<CopCard> lista;
  QRScanPage({Key? key, required this.lista}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {

  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: Palette.raisinBlack,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context)
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
    key: qrkey,
    onQRViewCreated: _onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Palette.carGreen,
      borderRadius: 10,
      borderLength: 30,
      borderWidth: 20,
      cutOutSize: 300,
    ),
  );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      if(checkCode(scanData)){
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Coupon Scanned'),
            content: Text('Coupon Scanned'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  controller.resumeCamera();
                },
              )
            ],
          ),
        );
      }
    });
  }

  var index;

  bool checkCode(Barcode? code){
    var data = code!.code;
    for(var i = 0; i < widget.lista.length; i++){
      if(data == widget.lista[i].qrCode){
        index = i;
        return true;
      }
    }
    return false;
  }

}


