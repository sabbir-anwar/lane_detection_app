import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  ImagePreview(this.file,{super.key});
  XFile file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(title: Text("Preview Image"),),

      body: Center(
          child: Image.file(picture),
        ),
    );
  }
}

class ImageUploadService{
  Future<void> uploadImage(XFile? pickedFile) async {
    try{
      Dio dio = Dio();

      if(pickedFile !=null){
        FormData formData = FormData.fromMap({
          'userFile': await MultipartFile.fromFile(pickedFile.path,filename:'image.jpg'),
        });

        // send the POST request with the FormData
        Response response = await dio.post(
          'api endpoint',
          data: formData,
        );

        if(response.statusCode == 200){
          print('Image uploaded successfully');
          print(response.data);
        } else {
          print('Image upload failed. Error: ${response.statusCode}');
        }
      } else {

      }
    } catch(error) {
      print('Error uploading image: $error');
    }
  }
}