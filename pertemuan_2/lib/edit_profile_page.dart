import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String initialNama;
  final String initialTentang;
  final String initialPendidikan;
  final String initialKontak;
  final String initialProyek;
  final String? initialImagePath;

  const EditProfilePage({
    super.key,
    required this.initialNama,
    required this.initialTentang,
    required this.initialPendidikan,
    required this.initialKontak,
    required this.initialProyek,
    this.initialImagePath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController namaController;
  late TextEditingController tentangController;
  late TextEditingController pendidikanController;
  late TextEditingController kontakController;
  late TextEditingController proyekController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.initialNama);
    tentangController = TextEditingController(text: widget.initialTentang);
    pendidikanController = TextEditingController(text: widget.initialPendidikan);
    kontakController = TextEditingController(text: widget.initialKontak);
    proyekController = TextEditingController(text: widget.initialProyek);
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
        title: const Text('Edit Profil'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.blue.shade100, width: 2),
                    ),
                    child: ClipOval(
                      child: imagePath != null && imagePath!.isNotEmpty
                          ? (kIsWeb
                          ? Image.network(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('asset/foto_saya1.jpg', fit: BoxFit.cover);
                        },
                      )
                          : Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('asset/foto_saya1.jpg', fit: BoxFit.cover);
                        },
                      ))
                          : Image.asset('asset/foto_saya1.jpg', fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 18,
                      child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            _buildTextField(namaController, 'Nama Lengkap', Icons.person),
            _buildTextField(tentangController, 'Tentang Saya', Icons.info, maxLines: 3),
            _buildTextField(pendidikanController, 'Pendidikan', Icons.school),
            _buildTextField(kontakController, 'Kontak', Icons.email),
            _buildTextField(proyekController, 'Proyek', Icons.folder_open, maxLines: 3),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nama': namaController.text,
                    'tentang': tentangController.text,
                    'pendidikan': pendidikanController.text,
                    'kontak': kontakController.text,
                    'proyek': proyekController.text,
                    'imagePath': imagePath,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    tentangController.dispose();
    pendidikanController.dispose();
    kontakController.dispose();
    proyekController.dispose();
    super.dispose();
  }
}