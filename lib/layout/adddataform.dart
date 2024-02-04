import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/add_news_bloc.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final TextEditingController _judul = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _date = TextEditingController();
  File? _pickedimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _judul,
              decoration: InputDecoration(labelText: "Masukkan Judul"),
            ),
            TextField(
              controller: _deskripsi,
              decoration: InputDecoration(labelText: "Masukkan Deskripsi"),
            ),
            TextField(
              controller: _date,
              decoration: InputDecoration(labelText: "Masukkan Tanggal"),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formatddate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _date.text = formatddate;
                  });
                }
              },
            ),
            _pickedimage != null
                ? Container(
                    height: 300,
                    child: Image.file(
                      _pickedimage!,
                      fit: BoxFit.cover,
                    ))
                : SizedBox.shrink(),
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg'],
                  );

                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _pickedimage = File(result.files.single.path!);
                    });
                  }
                },
                child: Text("Ambil Gambar")),
            ElevatedButton(
                onPressed: () async {
                  if (_pickedimage == null) {
                    _judul.text = "";
                    _deskripsi.text = "";
                    _date.text = "";

                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text("Tidak ada gambar"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text("Silahkan lengkapi data"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            ));
                  } else {
                    final title = _judul.text;
                    final content = _deskripsi.text;
                    final date = _date.text;
                    final image = _pickedimage;

                    context.read<AddNewsBloc>().add(ClickTombolAddEvent(
                        title: title,
                        desc: content,
                        date: date,
                        image: image!));
                  }
                },
                child: Text("Simpan News"))
          ],
        ),
      ),
    );
  }
}
