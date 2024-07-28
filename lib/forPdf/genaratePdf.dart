import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfApi {
  static Future<File> generatePdf() async {
    final pdf = pw.Document();

    const PdfColor secondaryColor = PdfColors.tealAccent;

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(0),
        build: (context) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(5.0),
            color: PdfColors.white,
            child: pw.Column(
              children: [
                pw.Container(
                  width: double.infinity,
                  margin: const pw.EdgeInsets.only(bottom: 5),
                  decoration: const pw.BoxDecoration(
                    color: secondaryColor,
                    borderRadius: pw.BorderRadius.only(
                      topLeft: pw.Radius.circular(50),
                    ),
                  ),
                  padding: const pw.EdgeInsets.all(30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        // name!,
                        "Adil",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      pw.Text(
                        "subtitle!",
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
    return saveDocument(name: "myResume.pdf", pdf: pdf);
  }

  // static Widget customHeader() => Header(
  //       margin: EdgeInsets.all(0),
  //       decoration: BoxDecoration(color: PdfColors.green),
  //       padding: EdgeInsets.all(30),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 "Adil Hussain Tapadar",
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 24,
  //                 ),
  //               ),
  //               SizedBox(width: 5),
  //               Text(
  //                 "Flutter Expert",
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 10),
  //           Container(
  //             width: 200,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("Email: adil@gmail.com"),
  //                 Text("Phone: 07459502020"),
  //                 Text("Flat 34 Westbourne Road, Downend, Bristol BS16 6RX"),
  //                 Text("linkedin.com/itss-adil"),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //
  // static Widget description() => Padding(
  //       padding: EdgeInsets.all(30),
  //       child: Text(
  //         LoremText().paragraph(60),
  //         style: TextStyle(color: PdfColors.grey900, letterSpacing: 1.3),
  //         textAlign: TextAlign.justify,
  //       ),
  //     );

  static Future<File> saveDocument(
      {required String name, required pw.Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationCacheDirectory();
    final file = File("${dir.path}/$name");

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    return OpenFile.open(url);
  }
}
