import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerTest extends StatefulWidget {
  FilePickerTest({Key? key}) : super(key: key);

  @override
  _FilePickerTestState createState() => _FilePickerTestState();
}

class _FilePickerTestState extends State<FilePickerTest> {
  Future<void> _showMyDialog(String fileType, String? path) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$fileType Path'),
          content: Text(path ?? ''),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select an image',
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      _showMyDialog('PDF', result.files.single.path);
    } else {}
  }

  void _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select a PDF file',
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      type: FileType.custom,
    );
    if (result != null) {
      _showMyDialog('PDF', result.files.single.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(
              Icons.picture_as_pdf,
              color: Colors.redAccent,
            ),
            onPressed: _pickPDF,
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            icon: const Icon(
              Icons.image,
              color: Colors.redAccent,
            ),
            onPressed: _pickImage,
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('File Picker'),
      ),
    );
  }
}
