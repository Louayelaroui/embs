import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_widgets;

import '../../../helper/AccesPhoneStorage.dart';
import '../../../reposetories/constants.dart';



class PrintPdfBtn extends StatefulWidget {
  const PrintPdfBtn({Key? key, required this.text, required this.screenKey, required this.fileName}) : super(key: key);
  final String text ;
  final String fileName ;
  final GlobalKey screenKey ;

  @override
  State<PrintPdfBtn> createState() => _PrintPdfBtnState();
}

class _PrintPdfBtnState extends State<PrintPdfBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final pdf_doc = pdf_widgets.Document();
        final screenRenderObject = widget.screenKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        await Future.delayed(Duration(milliseconds: 20)); // Wait for the widget to finish painting
        final image = await screenRenderObject.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        final imageWidget = pdf_widgets.Image(pdf_widgets.MemoryImage(byteData!.buffer.asUint8List()));


        pdf_doc.addPage(
          pdf_widgets.Page(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pdf_widgets.Center(
                child: imageWidget,
              );
            },
          ),
        );



        var nowMill =DateTime.now().millisecondsSinceEpoch;


        bool isOk = await AccessPhoneStorage.instance.saveIntoStorage(fileName: "${widget.fileName}_${nowMill}.pdf", data: await pdf_doc.save());

        if (isOk) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.fileName}_${nowMill}.pdf  Saved'),
          ));

        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
          )

      ),
      child: Text(tr("${widget.text}"), style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),),

    );
  }
}
