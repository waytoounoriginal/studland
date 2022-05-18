import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studland/colors.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

Color calculateTextColor(Color background) {
  return background.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
}


class Coupons extends StatefulWidget {
  const Coupons({Key? key}) : super(key: key);

  @override
  State<Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> with TickerProviderStateMixin {

  List colors = [];

  List<CopCard> coupons = [
    // CopCard(color: Colors.green, title: 'STARBUCKS', subtitle: '20% OFF!', qrCode: "1234",),
    // CopCard(color: Colors.red, title: 'STARBUCKS', subtitle: '20% OFF!', qrCode: "1234"),
    // CopCard(color: Colors.blue, title: 'Discord', subtitle: '20% OFF!', qrCode: "1234"),

  ];

  var textColor;
  bool loading = true;


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

  @override
  void dispose() {
    coupons.clear();
    super.dispose();
  }

  Future<int> _getCoupons() async {
    try {
      var url = Uri.parse('https://automemeapp.com/StudLand/select.php');
      final response = await http.post(url, body: {
        'index': '0',
      });
      if(response.statusCode != 200) {

      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);

        if(jsondata['1']['error']){
          print(jsondata['message']);
        }

        if(jsondata['1']['success']){
          var oferta = jsondata['oferta'].toString();
          var firma = jsondata['firma'].toString();
          //var color = Color(int.parse(jsondata['color']));

          for(int i = 2; i < jsondata.length; i++){
            var index = i.toString();

            var oferta = jsondata[index]['oferta'];
            var firma = jsondata[index]['firma'];
            var color = jsondata[index]['color'];
            var image = jsondata[index]['image'];

            var range;
            if(jsondata[index]['inceput'] != null && jsondata[index]['sfarsit'] != null){
              DateTime? inceput = DateTime.parse(jsondata[index]['inceput']);
              DateTime? sfarsit = DateTime.parse(jsondata[index]['sfarsit']);

              range = DateTimeRange(
                start: DateTime(inceput.year, inceput.month, inceput.day),
                end: DateTime(sfarsit.year, sfarsit.month, sfarsit.day),

              );
            }



            if(oferta != null && firma != null && color != null){
              var color2 = Color(int.parse(color));
              var cop = CopCard(color: color2, title: firma, subtitle: oferta, qrCode: jsondata[index]['nr'].toString(), validity: range, image: image,);
              setState(() {
                coupons.add(cop);
              });
            }


          }
          //print(color);

        }

      }
      if(coupons.isNotEmpty){
        contColor = Color.alphaBlend(coupons[0].color, Colors.white).withOpacity(0.25);
        title = coupons[0].title;
        description = coupons[0].subtitle;
        validity = '${DateFormat('dd/MM/yyyy').format(coupons[0].validity.start)} - ${DateFormat('dd/MM/yyyy').format(coupons[0].validity.end)}';
        textColor = calculateTextColor(contColor);
        image = coupons[0].image;
      }
    } catch(e, stacktrace) {
      print(e);
      print(stacktrace);
      //return 'Cannot connect. Please try again later.';
    }
    loading = false;
    return 1;
  }


  var title, description, image, dImage, validity;

  int? index;

  void revealQrCode(int index) {
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
                    data: coupons[index].qrCode!,
                    version: QrVersions.auto,
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }



  @override
  void initState() {

    loading = true;

    _getCoupons();
    index = 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Palette.raisinBlack,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text('Coupons', style: TextStyle(color: Palette.raisinBlack)),
        actions: [
          TextButton.icon(
            label: Text('Scan', style: TextStyle(color: Palette.raisinBlack)),
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
                  child: coupons.isNotEmpty
                      ? CarouselSlider(
                    items: coupons,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.5,
                      aspectRatio: 2,
                      viewportFraction: 0.5,
                      enableInfiniteScroll: true,
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

                          //title, description, image, dImage, validity
                          title = coupons[index].title;
                          description = coupons[index].subtitle;
                          this.index = index;
                          textColor = calculateTextColor(contColor);
                          image = coupons[index].image;

                          validity = '${DateFormat('dd/MM/yyyy').format(coupons[index].validity.start)} - ${DateFormat('dd/MM/yyyy').format(coupons[index].validity.end)}';


                        });
                        await Future.delayed(Duration(milliseconds: 500));
                        setState(() {
                          contHeight = 300;
                        });

                      },
                    ),
                  )
                      : Center(
                          child: loading
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Palette.carGreen),
                          )
                              : Text('No coupons available :(', style: TextStyle(fontSize: 20, color: Palette.raisinBlack.withOpacity(0.5)),)
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
                    child: title != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            image != null ? Image.network(image, height: 100, width: 100,) : Container(),
                            const SizedBox(width: 10,),
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Validity: ${validity.toString()}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: textColor.withOpacity(0.5)
                            ),
                          ),
                        ),
                        const SizedBox(height: 25,),
                        SizedBox(
                          height: 75,
                          child: dImage != null
                              ? Image.network(dImage, height: 100, width: 100,)
                              : Text(description, style: TextStyle(color: textColor, fontWeight: FontWeight.w300, fontSize: 20),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(onPressed: () {
                              revealQrCode(index!);
                            }, icon: Icon(Icons.qr_code_rounded, color: textColor,), label: Text(
                              'Reveal QR Code',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: textColor
                              ),
                            ),),

                          ],
                        ),

                      ],
                    ) : Container(),
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
  final DateTimeRange validity;
  const CopCard({Key? key, required this.color, required this.title, required this.subtitle, this.image, this.descrImg, required this.qrCode, required this.validity}) : super(key: key);

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
  }

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round()
    );
  }


  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CouponClipper(),
      child: Container(
        width: 500,
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darken(color, 50),
              lighten(color, 10),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),

          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              image != null
                  ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Image.network(image!, height: 100,),
                  )
                  : Container(),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 100,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  DateTime? lastScan;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
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
    controller.scannedDataStream.listen((scanData) async {
      final currentScan = DateTime.now();
      if (lastScan == null || currentScan.difference(lastScan!) > const Duration(seconds: 1)) {
        lastScan = currentScan;

        controller.pauseCamera();
        if(checkCode(scanData)){

          try {
            var url = Uri.parse('https://automemeapp.com/StudLand/scan.php');
            final response = await http.post(url, body: {
              'id': scanData.code.toString(),
            });
            if (response.statusCode != 200) {

            } else {
              var jsondata = json.decode(response.body);
              print(jsondata);
              print(index);

              if (jsondata['error']) {
                _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  content: Text(jsondata['message'], style: const TextStyle(fontFamily: 'Nunito'),),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ));
                controller.resumeCamera();
              }

              if(jsondata['success']){
                _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  content: Text(jsondata['message'], style: const TextStyle(fontFamily: 'Nunito'),),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));

                await Future.delayed(Duration(seconds: 2));

                Navigator.pop(_scaffoldKey.currentState!.context);
              }



            }
          } catch(e, stacktrace) {
            print(e);
            print(stacktrace);
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text('Error: $e', style: const TextStyle(fontFamily: 'Nunito'),),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ));
            controller.resumeCamera();
          }
      }




      }
    });
  }

  var index;




  bool checkCode(Barcode? code){
    var data = code!.code;
    for(var i = 0; i < widget.lista.length; i++){
      if(data == widget.lista[i].qrCode){
        index = i + 2;
        return true;
      }
    }
    return false;
  }

}


