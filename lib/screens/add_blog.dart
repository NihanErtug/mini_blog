import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _fromKey = GlobalKey<FormState>();
  String blogTitle = "";
  String blogContent = "";
  String author = "";
  XFile? selectedImage;

  void _submit() async {
    if (selectedImage != null) {
      Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
      var request = http.MultipartRequest("POST", url);
      request.fields["Title"] = blogTitle;
      request.fields["Content"] = blogContent;
      request.fields["Author"] = author;

      final file =
          await http.MultipartFile.fromPath("File", selectedImage!.path);
      request.files.add(file);
      final response = await request.send();

      if (response.statusCode == 201) {
        Navigator.pop(context);
      }
    }
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yeni Blog Ekle"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _fromKey,
              child: Column(children: [
                ElevatedButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text("Fotoğraf Seç")),
                if (selectedImage != null)
                  Image.file(
                    File(selectedImage!.path),
                    height: 250,
                  ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Blog Başlığı Giriniz"),
                  ),
                  onSaved: (newValue) {
                    blogTitle = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Blog başlığı boş olamaz";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Blog İçeriği Giriniz"),
                  ),
                  onSaved: (newValue) {
                    blogContent = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Blog içeriği boş olamaz";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Yazar Adı Giriniz"),
                  ),
                  onSaved: (newValue) {
                    author = newValue!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Yazar adı boş olamaz";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        _fromKey.currentState!.save();
                        _submit();
                      }
                    },
                    child: const Text("Kaydet"))
              ]),
            ),
          ),
        ));
  }
}
