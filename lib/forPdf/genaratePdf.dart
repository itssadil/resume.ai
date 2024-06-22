import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generatePdf() async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        margin: const EdgeInsets.all(0),
        build: (context) => [
          customHeader(),
          description(),
        ],
      ),
    );
    return saveDocument(name: "myResume.pdf", pdf: pdf);
  }

  static Widget customHeader() => Header(
        margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: PdfColors.green),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Adil Hussain Tapadar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Flutter Expert",
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: adil@gmail.com"),
                  Text("Phone: 07459502020"),
                  Text("Flat 34 Westbourne Road, Downend, Bristol BS16 6RX"),
                  Text("linkedin.com/itss-adil"),
                ],
              ),
            ),
          ],
        ),
      );

  static Widget description() => Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          LoremText().paragraph(60),
          style: const TextStyle(color: PdfColors.grey900, letterSpacing: 1.3),
          textAlign: TextAlign.justify,
        ),
      );

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
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
