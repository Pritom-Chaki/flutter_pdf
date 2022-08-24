import 'package:flutter/material.dart';
import 'package:flutter_pdf/pdfx/pinch.dart';
import 'package:flutter_pdf/pdfx/simple.dart';
import 'package:universal_platform/universal_platform.dart';

class PDFx extends StatefulWidget {
  const PDFx({Key? key}) : super(key: key);

  @override
  State<PDFx> createState() => _PDFxState();
}

class _PDFxState extends State<PDFx> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    darkTheme: ThemeData.dark(),
    home: UniversalPlatform.isWindows
        ? const SimplePage()
        : const PinchPage(),
  );
}