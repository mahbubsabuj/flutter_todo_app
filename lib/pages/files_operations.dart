import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FilesOperations extends StatefulWidget {
  const FilesOperations({Key? key}) : super(key: key);

  @override
  State<FilesOperations> createState() => _FilesOperationsState();
}

class _FilesOperationsState extends State<FilesOperations> {
  String _path = '';
  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$name');
      _path = '${appStorage.path}/$name';

      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print("File has been downloaded.");
      return file;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<File?> pickLocalFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future openLocalFile() async {
    final file = await pickLocalFile();
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future openDownloadedFile() async {
    OpenFile.open(_path);
  }

  Future printPaths() async {
    final tempDir = await getTemporaryDirectory();
    final supportDir = await getApplicationSupportDirectory();
    final documentDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print(tempDir.path);
      print(supportDir.path);
      print(documentDir.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Working with Files'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => openFile(
                  url: 'http://www.africau.edu/images/default/sample.pdf',
                  fileName: 'sample.pdf'),
              child: const Text("Download and Open File"),
            ),
            ElevatedButton(
              onPressed: () => downloadFile(
                  'http://www.africau.edu/images/default/sample.pdf',
                  'sample.pdf'),
              child: const Text("Download File"),
            ),
            ElevatedButton(
              onPressed: openDownloadedFile,
              child: const Text("Open Downloaded File"),
            ),
            ElevatedButton(
              onPressed: openLocalFile,
              child: const Text('Open Local File'),
            ),
            ElevatedButton(
              onPressed: printPaths,
              child: const Text("Path Provider Supported Paths"),
            ),
          ],
        ),
      ),
    );
  }
}
