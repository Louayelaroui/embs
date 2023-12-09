import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AccessPhoneStorage {
  static const _rootAppFolder = 'kine';
  Directory? _directory;
  File? _file;
  String _fullPathAppRootDir = '';

  // singleton
  AccessPhoneStorage._privateConst();
  static final AccessPhoneStorage instance = AccessPhoneStorage._privateConst();

  factory AccessPhoneStorage() {
    return instance;
  }

  File? docFile() => _file;

  Future<String> getDownloadsDirectoryPath() async {
    Directory? downloadsDir;

    if (Platform.isAndroid) {
      downloadsDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDir = await getApplicationDocumentsDirectory();
    }

    return downloadsDir!.path;
  }

  Future<void> _createRootAppDirectory() async {
    try {
      _directory = null;
      final downloadsPath = await getDownloadsDirectoryPath();
      _directory = Directory('$downloadsPath/$_rootAppFolder');
      await _directory!.create(recursive: true);
    } catch (e) {
      debugPrint('Failed to create app directory: $e');
    }
  }

  Future<void> createSubDirectory({required String folderName}) async {
    try {
      // create root app folder
      if (_directory == null || (_directory != null && !await _directory!.exists())) {
        await _createRootAppDirectory();
      }

      // create subdirectory
      final subDirectory = Directory('$_fullPathAppRootDir/$_rootAppFolder/$folderName');
      await subDirectory.create(recursive: true);

      if (await subDirectory.exists()) {
        debugPrint('Subdirectory created successfully');
      } else {
        debugPrint('Failed to create subdirectory');
      }
    } catch (e) {
      debugPrint('Failed to create subdirectory: $e');
    }
  }

  Future<bool> saveIntoStorage({required String fileName, dynamic data, bool writeAsString = false}) async {
    bool result = false;

    try {
      // check if the directory is null or does not exist
      if (_directory == null || !await _directory!.exists()) {
        await _createRootAppDirectory();
      }

      // save file to the application directory
      if (await _directory!.exists()) {
        _file = File("${_directory!.path}/$fileName");
        print(_file?.path);

        // save data
        if (writeAsString) {
          await _file?.writeAsString(data); // for json, txt
        } else {
          await _file?.writeAsBytes(data); // for pdf, image
        }

        // check if the file exists
        if (_file != null && _file!.existsSync()) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      debugPrint('Failed to save data: $e');
    }

    return result;
  }
}
