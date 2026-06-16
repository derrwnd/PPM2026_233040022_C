import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPengalamanPage extends StatefulWidget {
  final String? initialJudul;
  final String? initialDeskripsi;
  final String? initialImagePath;

  const EditPengalamanPage({
    super.key,
    this.initialJudul,
    this.initialDeskripsi,
    this.initialImagePath,
  });

  @override
  State<EditPengalamanPage> createState() => _EditPengalamanPageState();
}

class _EditPengalamanPageState extends State<EditPengalamanPage> {
  late TextEditingController judulController;
  late TextEditingController deskripsiController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.initialJudul ?? '');
    deskripsiController = TextEditingController(text: widget.initialDeskripsi ?? '');
    imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('Upload Pengalaman'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Foto Pengalaman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: imagePath != null && imagePath!.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: kIsWeb
                      ? Image.network(imagePath!, fit: BoxFit.cover)
                      : Image.file(File(imagePath!), fit: BoxFit.cover),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 50, color: Colors.blue.shade200),
                    const SizedBox(height: 8),
                    const Text('Klik untuk upload/ubah foto', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: judulController,
              decoration: InputDecoration(
                labelText: 'Judul Pengalaman',
                prefixIcon: const Icon(Icons.title, color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: deskripsiController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Deskripsi Singkat',
                prefixIcon: const Icon(Icons.description, color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'judul': judulController.text,
                    'deskripsi': deskripsiController.text,
                    'imagePath': imagePath,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Simpan Pengalaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }
}