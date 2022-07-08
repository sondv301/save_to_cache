import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:save_to_cache/save_to_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Save To Cache Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File fileSelect = File('');
  String nameFileSelect = 'file-select.example';
  String pathSave = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save To Cache Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: _onSelectFile,
            child: const Text('Select File'),
          ),
          Text(nameFileSelect),
          const Divider(),
          TextButton(
            onPressed: () => _onSaveFileToCache(),
            child: const Text('Save file to cache'),
          ),
          TextButton(
            onPressed: () => _onSaveFileToCache(name: 'save new'),
            child: const Text('Save file to cache with name'),
          ),
          Text(pathSave)
        ],
      ),
    );
  }

  Future<void> _onSelectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      fileSelect = File(result.files.single.path!);
      setState(() => nameFileSelect = result.files.single.name);
    }
  }

  Future<void> _onSaveFileToCache({String? name}) async {
    var result = await SaveToCache.saveFile(fileSelect, name: name);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Successful! $result'),
        ),
      );
  }
}
