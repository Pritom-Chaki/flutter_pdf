import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CertificateDownload extends StatefulWidget {
  const CertificateDownload(
      {Key? key, required this.certificateData, required this.certificatePath})
      : super(key: key);
  final String certificateData;
  final String certificatePath;

  @override
  State<CertificateDownload> createState() =>
      _CertificateDownloadState();
}

class _CertificateDownloadState extends State<CertificateDownload> {
  Uint8List? _documentBytes =Uint8List.fromList( [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100,33, 32, 224, 166, 185, 224, 166, 184, 224, 167, 141, 224, 166, 164, 224, 166, 190,224, 166, 168, 224, 167, 141, 224, 166, 164, 224, 166, 176, 32, 224, 166, 166, 224,166, 178, 224, 166, 191, 224, 166, 178, 32, 224, 166, 176, 224, 167, 135, 224, 166,156, 224, 166, 191, 224, 166, 184, 224, 167, 141, 224, 166, 159, 224, 167, 141, 224,166, 176, 224, 167, 135, 224, 166, 182, 224, 166, 168, 224, 167, 135, 224, 166, 176,32, 224, 166, 167, 224, 166, 190, 224, 166, 170, 32, 224, 166, 184, 224, 166, 174, 224,167, 130, 224, 166, 185] );

  @override
  void initState() {
    unitList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Certificate"),
        ),
        body:SfPdfViewer.file(pdfFile()));
  }

  File pdfFile() {
    if (Platform.isIOS) {
      return File(widget.certificatePath + "/" + widget.certificateData + '.pdf'); // for ios
    } else if (Platform.isAndroid) {
      print("aaaaa ${widget.certificatePath}");
      // File('storage/emulated/0/Download/' + cfData + '.pdf')
      return File(widget.certificatePath + "/" + widget.certificateData + '.pdf'); // for android
    } else {
      print("DDDD ${widget.certificatePath}");

      return File(widget.certificatePath + "/" + widget.certificateData + '.pdf');
    }
  }

  unitList() async  {
    // Uint8List uint8list = Uint8List.fromList(File(widget.certificatePath + "/" + widget.certificateData + '.html').readAsBytesSync());
    // print("uint8list == $uint8list");
   // File file = File(widget.certificatePath + "/" + widget.certificateData + '.html');
    File file = File('./assets/hello.pdf');
    print("file == $file");
    //Uint8List bytes =  file.readAsBytesSync();
    //print("bytes == $bytes");
  //  return bytes;
     final value = await file.readAsBytes() ;
   // print("_documentBytes == $_documentBytes");
    setState(() {
    _documentBytes = value;  //  print("_documentBytes == ${_documentBytes}");

    });
  }
}
