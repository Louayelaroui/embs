import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomAvatarImage extends StatefulWidget {
  const CustomAvatarImage({Key? key, this.playerImage, this.onPlayerImageChange}) : super(key: key);

  final String? playerImage;
  final Function(String?)? onPlayerImageChange;


  @override
  State<CustomAvatarImage> createState() => _CustomAvatarImageState();
}

class _CustomAvatarImageState extends State<CustomAvatarImage> {

  String? playerImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playerImage = widget.playerImage;
  }
  Future<String?> uploadImage(XFile pickedFile) async{
    if(Platform.isAndroid || Platform.isAndroid){
      CroppedFile? croppedFile = await cropperImage(pickedFile.path);
      // Uint8List  data= await croppedFile!.readAsBytes();
      pickedFile = CroppedFile !=null ? new XFile(croppedFile!.path) : pickedFile;
    }

    try {


    } catch (error) {
      print(error);
    }
    return null;
  }

  Future<CroppedFile?> cropperImage(String sourcePath)async{


    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),

      ],
    );
    return croppedFile;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.blue,
          foregroundImage: playerImage != null? NetworkImage(playerImage!): null,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                showDialog(context: context, builder: (builder){
                  var picker = ImagePicker();
                  return AlertDialog(
                    title: Text('Choose_Picture_from'.tr()),
                    contentPadding: const EdgeInsets.all(10),
                    content: Container(
                      height: 150,
                      width: 250,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            const Divider(color: Colors.black),
                            buildDialogItem(
                                context,
                                'Camera'.tr(),
                                Icons.add_a_photo_outlined,
                                ImageSource.camera,
                                    () async {
                                  if(mounted){
                                    Navigator.of(context).pop();
                                  }
                                  var file = await picker.pickImage(source: ImageSource.camera);
                                  if(file != null){
                                    uploadImage(file).then((value){
                                      if(mounted){
                                        setState(() {
                                          playerImage = value;
                                          widget.onPlayerImageChange?.call(value);
                                        });
                                      }
                                    });

                                  }
                                }
                            ),

                            const SizedBox(height: 10),
                            buildDialogItem(context, 'Gallery'.tr(),
                                Icons.image_outlined, ImageSource.gallery,
                                    () async {
                                  if(mounted){
                                    Navigator.of(context).pop();
                                  }
                                  if(Platform.isAndroid || Platform.isIOS){


                                    XFile? file = await picker.pickImage(source: ImageSource.gallery);

                                    if(file != null){
                                      uploadImage(file).then((value){
                                        if(mounted){
                                          setState(() {
                                            playerImage = value;
                                            widget.onPlayerImageChange?.call(value);
                                          });
                                        }
                                      });
                                    }
                                  }
                                  if(Platform.isWindows || Platform.isLinux){
                                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                                    if (result != null) {
                                      // File file = File(result.files.single.path!);
                                      XFile file =XFile(result.files.single.path!);
                                      uploadImage(file).then((value){
                                        if(mounted){
                                          setState(() {
                                            playerImage = value;
                                            widget.onPlayerImageChange?.call(value);
                                          });
                                        }
                                      });
                                    } else {
                                      // User canceled the picker
                                    }
                                  }

                                }),
                          ],
                        ),
                      ),
                    ),);
                });

              },
              child: const CircleAvatar(
                radius:15,
                backgroundColor: Colors.grey,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
            )
        )
      ],
    );
  }
}

Builder buildDialogItem(
    BuildContext context,
    String text,
    IconData icon,
    ImageSource src, Function()? onPress) {
  return Builder(
    builder: (innerContext) => Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0690b0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text),
        onTap: () async {
          onPress?.call();
        },
      ),
    ),
  );
}
