import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileEditPhoto extends StatefulWidget {
  // final UserProfileController _profileController = Get.find();
  final String? photoUrl;
  final Function(XFile?) setXFile;

  const UserProfileEditPhoto({
    Key? key,
    this.photoUrl,
    required this.setXFile,
  }) : super(key: key);

  @override
  State<UserProfileEditPhoto> createState() => _UserProfileEditPhotoState();
}

class _UserProfileEditPhotoState extends State<UserProfileEditPhoto> {
  final ImagePicker _picker = ImagePicker();
  XFile? _xfile;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _xfile != null
          ? Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: kIsWeb
                  ? Image.network(
                      _xfile!.path,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        //print('error 1');
                        return errorBuilderWidget();
                      },
                    )
                  : Image.file(
                      File(_xfile!.path),
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        //print('error 2');
                        return errorBuilderWidget();
                      },
                    ),
            )
          : widget.photoUrl == null
              ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Click aqui para buscar sua foto, apenas face. Padrão 3x4.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.photoUrl!,
                    // loadingBuilder: (_, __, ___) {
                    //   return const Center(
                    //       child: CircularProgressIndicator());
                    // },
                    height: 100,
                    width: 100,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      //print('error 3');
                      return errorBuilderWidget();
                    },
                  ),
                ),
      onTap: () async {
        //print('aqui...');
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          widget.setXFile(pickedFile);
          setState(() {
            _xfile = pickedFile;
          });
        }
      },
    );
  }

  Container errorBuilderWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text('Erro ao buscar esta imagem'),
      ),
    );
  }
}
