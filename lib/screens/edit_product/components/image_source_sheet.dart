import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final ImagePicker picker = ImagePicker();

  final Function(File) onImageSelected;

  // ignore: use_key_in_widget_constructors
  ImageSourceSheet({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    Future<void> editImage(String path) async {
      final File croppedFile = await ImageCropper.cropImage(
          sourcePath: path,
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Editar Imagem',
              toolbarColor: Theme.of(context).primaryColor,
              toolbarWidgetColor: Colors.white),
          iosUiSettings: const IOSUiSettings(
              title: 'Editar Imagem',
              cancelButtonTitle: 'Cancelar',
              doneButtonTitle: 'Concluir')
          //aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
          );
      if (croppedFile != null) {
        onImageSelected(croppedFile);
      }
    }

    if (Platform.isAndroid) {
      return BottomSheet(
          backgroundColor: Theme.of(context).primaryColor,
          onClosing: () {},
          builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      final PickedFile file =
                          await picker.getImage(source: ImageSource.camera);
                      editImage(file.path);
                    },
                    child: const Text(
                      'Câmera',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () async {
                      final PickedFile file =
                          await picker.getImage(source: ImageSource.gallery);
                      editImage(file.path);
                    },
                    child: const Text(
                      'Galeria',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ));
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar Foto'),
        message: const Text('Escolha a origem da Foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path);
            },
            child: const Text(
              'Câmera',
              style: TextStyle(fontSize: 18),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);
              editImage(file.path);
            },
            child: const Text(
              'Galeria',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      );
    }
  }
}
