import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


class GeneratePdfWidget extends StatelessWidget {
  const GeneratePdfWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GeneratePdfStatefulWidget(
          title: 'Unicode text using the Google Fonts'),
    );
  }
}

class GeneratePdfStatefulWidget extends StatefulWidget {
  const GeneratePdfStatefulWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  State<GeneratePdfStatefulWidget> createState() => _GeneratePdfState();
}

class _GeneratePdfState extends State<GeneratePdfStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: generatePdf,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue)),
              child: const Text(
                'Draw Text, Generate PDF',
                style: TextStyle(color: Colors.white),
              ),

            )
          ],
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    //Create the PDF document
    PdfDocument document = PdfDocument();
    //Add a page
    PdfPage page = document.pages.add();
    final Uint8List fontData = File('assets/fonts/Nikosh.ttf').readAsBytesSync();
    //Create a PDF true type font object.
   final PdfFont font = PdfTrueTypeFont(fontData, 12);
    //Set the font
  // PdfFont font = await getFont(GoogleFonts.anekBangla());
    //Draw a text
    page.graphics.drawString('Hello World হস্তান্তর দলিল রেজিস্ট্রেশনের ধাপ সমূহ', font,
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 0, 200, 30));
    //Save the document


    List<int> bytes = await document.save();
    //Dispose the document
    document.dispose();
    //Get the external storage directory
    Directory directory = (await getApplicationDocumentsDirectory());
    //Get the directory path
    String path = directory.path;
    //Create an empty file to write the PDF data
    File file = File('$path/output.pdf');
    //Write the PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/output.pdf');
  }

  Future<PdfFont> getFont(TextStyle style) async {
    //Get the external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Create an empty file to write the font data
    File file = File('${directory.path}/${style.fontFamily}.ttf');
    List<int>? fontBytes;
    //Check if entity with the path exists
    if (file.existsSync()) {
      fontBytes = await file.readAsBytes();
    }
    if (fontBytes != null && fontBytes.isNotEmpty) {
      //Return the google font
      return PdfTrueTypeFont(fontBytes, 12);
    } else {
      //Return the default font
      return PdfStandardFont(PdfFontFamily.helvetica, 12);
    }
  }
}
