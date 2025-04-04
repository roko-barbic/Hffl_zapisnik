import 'package:flutter/material.dart';
import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:share_plus/share_plus.dart';

class PdfPopupWidget extends StatelessWidget {
  final String pdfFilePath;
  final String pdfFileName;

  const PdfPopupWidget(
      {Key? key, required this.pdfFilePath, required this.pdfFileName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        height: 500, // Adjust popup height
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Close button at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    pdfFileName,
                    style: const TextStyle(
                      //color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 350,
                child: Builder(
                  builder: (context) {
                    return AlhPdfView(
                      filePath: pdfFilePath,
                      enableSwipe: true,
                      autoSpacing: true,
                      fitPolicy: FitPolicy.both,
                    );
                  }
                ),
              ),
            ),
            shareButtons(context),
          ],
        ),
      ),
    );
  }

  Widget shareButtons(BuildContext context) {
    return Row(
      key: const Key('share.actions'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            Share.shareXFiles(<XFile>[new XFile(pdfFilePath)],
                subject: "Izvjestaj");
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Icon(Icons.share),
          ),
        )
      ],
    );
  }
}
