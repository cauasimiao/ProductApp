import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Utility.dart';

class SaveImage extends StatefulWidget {
  final void Function(String fileString) onImageSelected;

  final String title = "Upload de imagem";
  SaveImage({this.onImageSelected}) : super();

  @override
  _SaveImageState createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  //
  Future<File> imageFile;
  Image imageFromPreferences;
  String selectedFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  void saveImage(File file) {
    selectedFile = Utility.base64String(file.readAsBytesSync());
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          saveImage(snapshot.data);

          return Image.file(
            snapshot.data,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Selecione uma imagem para o seu produto',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                pickImageFromGallery(ImageSource.gallery);
                setState(() {
                  imageFromPreferences = null;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                imageFromGallery(),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        disabledColor: Colors.grey,
                        child: Text(
                          "Confirmar imagem",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFF2EDDB)),
                        ),
                        color: Color(0xFF10223D),
                        textTheme: ButtonTextTheme.primary,
                        onPressed: selectedFile == null
                            ? null
                            : () {
                                widget.onImageSelected(selectedFile);
                                Navigator.pop(context);
                              },
                      ),
                    ),
                  ],
                ),
                null == imageFromPreferences
                    ? Container()
                    : imageFromPreferences,
              ],
            ),
          ),
        ));
  }
}
