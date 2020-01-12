import 'package:basic/stores/folder.store.dart';
import 'package:basic/widgets/custom_floating_button.widget.dart';
import 'package:basic/widgets/folder_image.widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:basic/models/model.dart' as model;
import 'package:basic/stores/image.store.dart';
import 'package:path_provider/path_provider.dart';

import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:scanny/scanny.dart';

import '../constants/constants.dart';
import '../widgets/custom_alert_dialog.widget.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pdfWidget;
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

//import 'package:image/image.dart' as importImage;

class FolderDetailScreen extends StatefulWidget {
  static const routeName = "folder-detail-screen";

  @override
  _FolderDetailScreenState createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  bool _isLoading = false;

  void _scanAndSaveImage(FolderStore folderStore, folderId) {
    setState(() {
      _isLoading = true;
    });
    final scanny = new Scanny();
    scanny.askPermissions;
    scanny.callScanner;
    scanny.getImageBytes.listen((imageBytes) {
      _saveImage(folderStore, folderId, imageBytes);
    });
  }

  void _saveImage(FolderStore folderStore, folderId, imageBytes) {
    folderStore.saveImageWithFolderId(folderId, imageBytes).then((result) {
      if (result == Constants.SUCCESS) {
        setState(() {
          _isLoading = false;
        });
        _showAlert(
            title: Constants.SUCCESS,
            content: Constants.SUCCESS_MESSAGE_IMAGE,
            onPressed: () {});
      }
    }).catchError(
      (onError) {
        setState(() {
          _isLoading = false;
        });
        _showAlert(title: Constants.ERROR_OCCURED, content: onError);
      },
    );
  }

  void _showAlert({String title, String content, Function onPressed}) {
    CustomAlertDialog(
      content: content,
      title: title,
      onPressed: onPressed,
    );
  }

  void convertToPdf(final List<model.Image> images, String title) async {
    setState(() {
      _isLoading = true;
    });
    final myPDF = pdfWidget.Document();

    for (int i = 0; i < images.length; i++) {
      final uint8list = File(images[i].imageUrl).readAsBytesSync();
      final imgDimension = img.decodeImage(uint8list);

      final myHeight = imgDimension.height ~/ 3;
      final myWidth = imgDimension.width ~/ 3;

      final codec = await ui.instantiateImageCodec(uint8list,
          targetHeight: myHeight, targetWidth: myWidth);

      final frame = await codec.getNextFrame();
      final image = frame.image;
      final imgx = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

      final imagePdf = pdf.PdfImage(myPDF.document,
          image: imgx.buffer.asUint8List(), width: myWidth, height: myHeight);

      final page = pdfWidget.Page(
        pageFormat: pdf.PdfPageFormat(
            myWidth * pdf.PdfPageFormat.mm, myHeight * pdf.PdfPageFormat.mm),
        build: (_) {
          return pdfWidget.Center(
              child: pdfWidget.Expanded(child: pdfWidget.Image(imagePdf)));
        },
      );

      myPDF.addPage(page);
    }

    final pdfName = '$title.pdf';
    final output = (await getTemporaryDirectory()).path;
    final file = File("$output/$pdfName");
    await file.writeAsBytes(myPDF.save());

    await Printing.sharePdf(bytes: myPDF.save(), filename: pdfName);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageStore = Provider.of<ImageStore>(context);
    final folderStore = Provider.of<FolderStore>(context);
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final folderId = args["id"];
    final title = args["title"];

    return _isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text("loading"),
            ),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            ),
            backgroundColor: Colors.black12,
          )
        : FutureBuilder(
            future: imageStore.findImagesByFolderId(folderId),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.teal,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return CustomAlertDialog(
                      title: Constants.ERROR_OCCURED,
                      content: snapshot.error,
                      onPressed: () {},
                    );
                  } else {
                    List<model.Image> result = snapshot.data;
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('$title'),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              convertToPdf(result, title);
                            },
                          ),
                        ],
                      ),
                      body: Column(
                        children: <Widget>[
                          Expanded(
                            child: GridView.builder(
                              itemCount: result.length,
                              itemBuilder: (_, index) {
                                return FolderImageWidget(
                                    result[index], index + 1);
                              },
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: screenSize.width / 2,
                                      childAspectRatio: 1 / 1.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: CustomFloatingButton(
                        onPressed: () {
                          _scanAndSaveImage(folderStore, folderId);
                          //folderStore.
                        },
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerFloat,
                    );
                  }
              }
            },
          );
  }
}
