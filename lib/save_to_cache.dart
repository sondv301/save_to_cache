library save_to_cache;

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveToCache {
  /// If the save is successful, the path of the saved file will be returned
  static Future<File> saveFile(File file, {String? name}) async {
    final Directory root = await _getRoot();
    final savePath =
        "${root.path}/${name ?? DateTime.now().millisecondsSinceEpoch}${_getFileExtension(file.path)}";
    File result = await file.copy(savePath);
    return result;
  }

  static String _getFileExtension(String path) {
    return ".${path.split('.').last}";
  }

  static Future<Directory> _getRoot() async {
    final Directory dir = await getTemporaryDirectory();
    Directory root = Directory("${dir.path}/save_to_cache");
    if (!(await root.exists())) {
      root.create();
    }
    return root;
  }
}
