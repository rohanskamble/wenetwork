import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
 // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //late QRViewController controller;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool flash=false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();

    }
    controller!.pauseCamera();
  }
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title:    Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              child: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  return Text('Flash: ${snapshot.data}');
                },
              )),
        ),
      ),*/
      body: Stack(
        children: [
          Column(
            children: <Widget>[
             /* Container(
               // margin: const EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 250,top: 30),
                  color: Colors.transparent,


                  child: ElevatedButton(
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});

                      },

                      child: FutureBuilder(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) {

                          return Text('Flash: ${snapshot.data}');
                        },
                      )),
                ),*/

              Expanded(flex: 4, child: _buildQrView(context)),

                  /*  Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.pauseCamera();
                              },
                              child: const Text('pause',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),*/



                ],
              ),

              /*Expanded(
                flex: 1,
                child: FittedBox(

                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (result != null)
                        Text(
                            'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                      else
                        const Text('Scan a code'),
                    *//*  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.toggleFlash();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    return Text('Flash: ${snapshot.data}');
                                  },
                                )),
                          ),
                        *//**//*  Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.flipCamera();
                                  setState(() {});
                                },
                                child: FutureBuilder(
                                  future: controller?.getCameraInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Text(
                                          'Camera facing ${describeEnum(snapshot.data!)}');
                                    } else {
                                      return const Text('loading');
                                    }
                                  },
                                )),
                          )*//**//*
                        ],
                      ),*//*
                     *//* Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                        *//**//*  Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.pauseCamera();
                              },
                              child: const Text('pause',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),*//**//*
                          Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.all(8),
                            width: 20,
                            height: 20,

                            child: ElevatedButton(
                             style: ButtonStyle(fixedSize:MaterialStateProperty.all(Size.square(10))),
                              onPressed: () async {
                                await controller?.resumeCamera();
                              },
                              child: const Text('Scan',
                                  style: TextStyle(fontSize: 5)),
                            ),
                          )


                        ],
                      ),*//*
                    ],
                  ),
                ),
              )*/

          Positioned(
            child:  Container(

            // margin: const EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 300,top: 30),
            color: Colors.transparent,


            child: IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {
                    flash=!flash;
                  });

                },
                  icon:Icon( flash?Icons.flash_off:Icons.flash_on,color: Colors.white,),
/*
                child: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {


                   // return Container(child: Text('Flash: ${snapshot.data}'));
                  },*/
                ),



          ),

          ),
          Positioned(
            child:  Container(

              // margin: const EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 350,top: 30),
              color: Colors.transparent,


              child: IconButton(
                onPressed: () async {

                  setState(() {
                    Navigator.pop(context);
                  });

                },
              icon:Icon(Icons.close,color: Colors.white,)
/*
                child: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {


                   // return Container(child: Text('Flash: ${snapshot.data}'));
                  },*/
              ),



            ),

          ),
          Positioned(
            bottom: 20,
            left: 150,
            width: 90,
            height: 90,

            child: Container(
            //  color: Colors.transparent,
            margin: const EdgeInsets.all(8),
            //  padding: EdgeInsets.only(left: 30),
              width: 20,
              height: 20,
              color:Colors.deepOrange,

              child:IconButton(
                color:Colors.deepOrange,
               // style: ButtonStyle(fixedSize:MaterialStateProperty.all(Size.square(10))),
                onPressed: () async {
                  await controller?.resumeCamera();
                },
                icon: Image.asset(
    "asset/image/scan.png",
    width: 50.0,
    ),
               /* child: const Text('Scan',
                    style: TextStyle(fontSize: 5)),*/
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 20,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  /*void _onQRViewCreated(QRViewController controller) {
    setState(()  {

      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(()  {

        result = scanData;

      });
    });
  }*/

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
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      String? data = scanData.code;
      Fluttertoast.showToast(
          msg: data??"No data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // Navigator.pop(context, data);
    });
  }
}











   /* return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      String? data = scanData.code;
      Fluttertoast.showToast(
          msg: data??"No data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
     // Navigator.pop(context, data);
    });
  }
}*/


