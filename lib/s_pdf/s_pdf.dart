import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class GeneratePdfWidget extends StatefulWidget {
  const GeneratePdfWidget({Key? key}) : super(key: key);

  @override
  State<GeneratePdfWidget> createState() => _GeneratePdfWidgetState();
}

class _GeneratePdfWidgetState extends State<GeneratePdfWidget> {
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

  TextEditingController textEditingController = TextEditingController();
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
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Input",
                labelStyle: TextStyle(fontSize: 14.0),
                hintStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 10.0,
                ),
              ),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                onPressed: ()=>generatePdf(textEditingController),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue)),
                child: const Text(
                  '??????????????????????????? ???????????? ??????????????????????????????????????????',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> generatePdf(TextEditingController textEditingController) async {
    //read font data
    Future<List<int>> _readData(String name) async {
      final ByteData data = await rootBundle.load(name);
      return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    }

    const String text =
        'Adventure Works Cycles, the fictitious company on which the AdventureWorks sample databases are based, is a large, multinational manufacturing company. The company manufactures and sells metal and composite bicycles to North American, European and Asian commercial markets. While its base operation is located in Bothell, Washington with 290 employees, several regional sales teams are located throughout their market base.';

    //Create the PDF document
    PdfDocument document =
        PdfDocument();
          // ..pages.add().graphics.drawString(
          //     'Hello World! ??????????????????????????? ???????????? ??????????????????????????????????????????',
          //     PdfTrueTypeFont(await _readData('./assets/fonts/Nikosh.ttf'), 12),
          //     bounds: const Rect.fromLTWH(20, 20, 200, 50));


      //Add a page
      PdfPage page = document.pages.add();
      var dir = await getTemporaryDirectory();
      var fontFile = await File("${dir.path}/font.ttf").create();
      var fontByteData = await rootBundle.load('assets/fonts/kalpurush.ttf');
      await fontFile.writeAsBytes(fontByteData.buffer.asUint8List(fontByteData.offsetInBytes, fontByteData.lengthInBytes));

      final Uint8List fontData = fontFile.readAsBytesSync();
      print("fontData == $fontData");
      //Create a PDF true type font object.
  final PdfFont font = PdfTrueTypeFont(fontData, 12, );
      //Set the font
  // PdfFont font = await getFont(GoogleFonts.notoSansBengali());
      //Draw a text
      page.graphics.drawString(textEditingController.text, font,
          brush: PdfBrushes.black, bounds: const Rect.fromLTWH(0, 0, 200, 30));
    //Save the document
   // File('output.pdf').writeAsBytes(document.save());
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
   await file.writeAsBytes(bytes);


    //Open the PDF document in mobile
    OpenFile.open('$path/output.pdf');
    // OpenFilex.open('$path/output.pdf');
  }

  Future<PdfFont> getFont(TextStyle style) async {
    //Get the external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Create an empty file to write the font data
   File file = File('${directory.path}\\${style.fontFamily}.ttf');
   // File file = File('./assets/font/${style.fontFamily}.ttf');
    print("FILE ==  $file");
    List<int>? fontBytes;
    //Check if entity with the path exists
    print("file.existsSync() ==  ${file.existsSync()}");
    if (file.existsSync()) {
      fontBytes = await file.readAsBytes();
      print("fontBytes ==  $fontBytes");
    }
    if (fontBytes != null && fontBytes.isNotEmpty) {
      print("fontBytes == $fontBytes");
      //Return the google font
      return PdfTrueTypeFont(fontBytes, 12);
    } else {
      //Return the default font
      return PdfStandardFont(PdfFontFamily.helvetica, 12);
    }
  }
  }

