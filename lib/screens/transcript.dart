import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:alh_pdf_view/lib.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool canDownload = false;
  Uint8List? downloadBody;

  Future<void> download() async {
    if (canDownload) {
      await DocumentFileSavePlus().saveMultipleFiles(
          dataList: [downloadBody!],
          fileNameList: ["transcriptGenibook.pdf"],
          mimeTypeList: ["appliation/pdf"]);

      if (!mounted) return;
    }
  }

  void showDownloadDialog() {
    if (canDownload) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text("Download your transcript?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () async {
                        await download();

                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Download',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ]);
          });
    }
  }

  AppBar buildAppbar(bool special) {
    var color = Colors.grey.shade500;
    if (special) {
      color = Theme.of(context).buttonTheme.colorScheme?.primary ?? Colors.blue;
      canDownload = true;
    }

    return AppBar(
      title: const Text('Transcript'),
      automaticallyImplyLeading: true,
      elevation: 2,
      shadowColor: Theme.of(context).shadowColor,
      actions: [
        Tooltip(
            message: "Download your transcript!",
            child: IconButton(
              onPressed: showDownloadDialog,
              icon: Icon(
                Icons.download,
                color: color,
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: ApiHandler.fetchPdfContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: buildAppbar(false),
              body: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              appBar: buildAppbar(false),
              body: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          // Display the PDF content using the PdfView widget
          downloadBody = snapshot.data;
          return Scaffold(
              appBar: buildAppbar(true),
              body: AlhPdfView(
                bytes: snapshot.data,
              ));
        }
      },
    );
  }
}
