import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'edit_pengalaman_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data Profil Utama
  String nama = 'ASEP DERI HERMAWAN';
  String tentangSaya = 'Belajar Flutter.';
  String pendidikan = 'Teknik Informatika Universitas Pasundan';
  String kontak = 'asep.233040022@unpas.ac.id';
  String pengalamanStatis = 'Freelance Web Developer';
  String proyek = 'TechFlow-Ticketing';
  List<String> skills = ['Flutter', 'Laravel', 'Java', 'PHP', 'UI/UX'];
  String? imagePath;

  // Data Pengalaman Dinamis (Hasil Sidebar Edit Pengalaman)
  String? uploadedJudul;
  String? uploadedDeskripsi;
  String? uploadedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.add_to_photos),
              title: const Text('Upload Pengalaman'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPengalamanPage(
                      initialJudul: uploadedJudul,
                      initialDeskripsi: uploadedDeskripsi,
                      initialImagePath: uploadedImagePath,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    uploadedJudul = result['judul'];
                    uploadedDeskripsi = result['deskripsi'];
                    uploadedImagePath = result['imagePath'];
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // Header Profil
            Center(
              child: Column(
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
                      ],
                    ),
                    child: ClipOval(
                      child: imagePath != null && imagePath!.isNotEmpty
                          ? (kIsWeb
                          ? Image.network(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('asset/foto_saya1', fit: BoxFit.cover);
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
                  const SizedBox(height: 14),
                  Text(
                    nama,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Mahasiswa Teknik Informatika Unpas',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: StatBox(label: 'Post', value: '10')),
                Expanded(child: StatBox(label: 'Teman', value: '100')),
                Expanded(child: StatBox(label: 'Like', value: '1000k')),
              ],
            ),
            const SizedBox(height: 30),

            SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: tentangSaya,
            ),
            SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: pendidikan,
            ),
            SectionCard(
              icon: Icons.email_outlined,
              title: 'Kontak',
              content: kontak,
            ),

            // KARTU PENGALAMAN DINAMIS (Muncul jika ada data)
            if (uploadedJudul != null && uploadedJudul!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.work_history, color: Colors.blue, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pengalaman (Terbaru)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            if (uploadedImagePath != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: kIsWeb
                                      ? Image.network(uploadedImagePath!, width: double.infinity, height: 150, fit: BoxFit.cover)
                                      : Image.file(File(uploadedImagePath!), width: double.infinity, height: 150, fit: BoxFit.cover),
                                ),
                              ),
                            Text(uploadedJudul!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(uploadedDeskripsi ?? '', style: const TextStyle(height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            SectionCard(
              icon: Icons.folder_open,
              title: 'Proyek',
              content: proyek,
            ),

            Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.star, color: Colors.blue, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Skills', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: skills.map((s) => Chip(label: Text(s))).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(
                initialNama: nama,
                initialTentang: tentangSaya,
                initialPendidikan: pendidikan,
                initialKontak: kontak,
                initialProyek: proyek,
                initialImagePath: imagePath,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              nama = result['nama'];
              tentangSaya = result['tentang'];
              pendidikan = result['pendidikan'];
              kontak = result['kontak'];
              proyek = result['proyek'];
              imagePath = result['imagePath'];
            });
          }
        },
        label: const Text('Edit Profil'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final String label;
  final String value;
  const StatBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const SectionCard({super.key, required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}