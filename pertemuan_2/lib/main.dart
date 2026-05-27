import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const ProfilePage(),
    );
  }
}

// =====================
// PROFILE PAGE
// =====================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text('Profil Saya'),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),

            onPressed: () {
              showDialog(
                context: context,

                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text(
                      'Fitur pengaturan belum tersedia.',
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ],
                ),
              ),

              child: Align(
                alignment: Alignment.bottomLeft,

                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
            ),

            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
            ),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),

              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GalleryHome(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // BODY
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFFFFFFF),
            ],
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [
              // HEADER PROFILE
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Asep Deri Hermawan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // STATISTIK
              Row(
                children: const [
                  Expanded(
                    child: _StatBox(
                      label: 'Post',
                      value: '12',
                    ),
                  ),

                  Expanded(
                    child: _StatBox(
                      label: 'Teman',
                      value: '78',
                    ),
                  ),

                  Expanded(
                    child: _StatBox(
                      label: 'Like',
                      value: '2.2K',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // SKILLS
              const Text(
                'Skills',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: const [
                  Chip(label: Text('Flutter')),
                  Chip(label: Text('Dart')),
                  Chip(label: Text('Firebase')),
                  Chip(label: Text('UI/UX')),
                  Chip(label: Text('HTML')),
                  Chip(label: Text('CSS')),
                ],
              ),

              const SizedBox(height: 24),

              const _SectionCard(
                icon: Icons.info_outline,
                title: 'Tentang Saya',
                content:
                'Saya suka belajar Flutter dan pengembangan aplikasi mobile.',
              ),

              const _SectionCard(
                icon: Icons.school,
                title: 'Pendidikan',
                content:
                'Universitas Pasundan - Semester 6',
              ),

              const _SectionCard(
                icon: Icons.favorite,
                title: 'Hobi & Minat',
                content:
                'Coding • Game • Musik • Fotografi',
              ),

              const _SectionCard(
                icon: Icons.email,
                title: 'Kontak',
                content:
                'deri@example.com\n+62 812-2104-2116',
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // FAB
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Edit profil belum tersedia',
              ),
            ),
          );
        },

        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),

      // NAVIGATION BAR
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),

          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

// =====================
// STAT BOX
// =====================

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(label),
      ],
    );
  }
}

// =====================
// SECTION CARD
// =====================

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================
// GALLERY HOME
// =====================

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ['Display', Icons.image, Colors.blue],
      ['Input', Icons.edit, Colors.green],
      ['Button', Icons.smart_button, Colors.orange],
      ['Feedback', Icons.notifications, Colors.purple],
      ['Layout', Icons.dashboard, Colors.teal],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Gallery'),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),

        itemCount: categories.length,

        separatorBuilder: (_, __) =>
        const SizedBox(height: 8),

        itemBuilder: (context, i) {
          final name =
          categories[i][0] as String;

          final icon =
          categories[i][1] as IconData;

          final color =
          categories[i][2] as Color;

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,

                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),

              title: Text(name),

              trailing:
              const Icon(Icons.chevron_right),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryPage(name: name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// =====================
// CATEGORY PAGE
// =====================

class CategoryPage extends StatelessWidget {
  final String name;

  const CategoryPage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (name) {
      case 'Display':
        body = const DisplayDemo();
        break;

      case 'Input':
        body = const InputDemo();
        break;

      case 'Button':
        body = const ButtonDemo();
        break;

      case 'Feedback':
        body = const FeedbackDemo();
        break;

      case 'Layout':
        body = const LayoutDemo();
        break;

      default:
        body = const Center(
          child: Text('?'),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}

// =====================
// DISPLAY DEMO
// =====================

class DisplayDemo extends StatelessWidget {
  const DisplayDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const Text(
          'Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(Icons.album),
            title: const Text('Judul Item'),
            subtitle: const Text('Subjudul'),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Chip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Wrap(
          spacing: 8,

          children: const [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('Mobile')),
          ],
        ),

        const SizedBox(height: 16),

        const Divider(),

        const SizedBox(height: 16),

        const Text(
          'CircleAvatar & Icon',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: const [
            CircleAvatar(
              child: Text('A'),
            ),

            SizedBox(width: 12),

            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check),
            ),

            SizedBox(width: 12),

            Icon(
              Icons.star,
              color: Colors.amber,
              size: 40,
            ),
          ],
        ),
      ],
    );
  }
}

// =====================
// INPUT DEMO
// =====================

class InputDemo extends StatefulWidget {
  const InputDemo({super.key});

  @override
  State<InputDemo> createState() =>
      _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  bool checked = false;
  bool switched = true;
  double slider = 0.5;
  String dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Ketik nama Anda',
          ),
        ),

        const SizedBox(height: 16),

        CheckboxListTile(
          title: const Text('Checkbox'),
          value: checked,

          onChanged: (v) {
            setState(() {
              checked = v ?? false;
            });
          },
        ),

        SwitchListTile(
          title: const Text('Switch'),
          value: switched,

          onChanged: (v) {
            setState(() {
              switched = v;
            });
          },
        ),

        const Text('Slider'),

        Slider(
          value: slider,

          onChanged: (v) {
            setState(() {
              slider = v;
            });
          },
        ),

        const SizedBox(height: 8),

        DropdownButton<String>(
          value: dropdown,

          items: ['Apel', 'Jeruk', 'Mangga']
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),

          onChanged: (v) {
            setState(() {
              dropdown = v!;
            });
          },
        ),
      ],
    );
  }
}

// =====================
// BUTTON DEMO
// =====================

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),

        const SizedBox(height: 8),

        FilledButton(
          onPressed: () {},
          child: const Text('Filled'),
        ),

        const SizedBox(height: 8),

        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined'),
        ),

        const SizedBox(height: 8),

        TextButton(
          onPressed: () {},
          child: const Text('Text Button'),
        ),

        const SizedBox(height: 8),

        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Dengan Icon'),
        ),

        const SizedBox(height: 8),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

// =====================
// FEEDBACK DEMO
// =====================

class FeedbackDemo extends StatelessWidget {
  const FeedbackDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,

      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content:
                Text('Halo dari SnackBar'),
              ),
            );
          },

          child:
          const Text('Tampilkan SnackBar'),
        ),

        const SizedBox(height: 16),

        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,

              builder: (_) => AlertDialog(
                title:
                const Text('Konfirmasi'),

                content: const Text(
                  'Yakin ingin lanjut?',
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text('Batal'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text('Ya'),
                  ),
                ],
              ),
            );
          },

          child:
          const Text('Tampilkan Dialog'),
        ),

        const SizedBox(height: 16),

        const Text('Progress Indicator'),

        const SizedBox(height: 8),

        const LinearProgressIndicator(
          value: 0.6,
        ),

        const SizedBox(height: 16),

        const Center(
          child:
          CircularProgressIndicator(),
        ),
      ],
    );
  }
}

// =====================
// LAYOUT DEMO
// =====================

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const Text(
          'Wrap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,

          children: List.generate(
            8,
                (i) => Container(
              padding:
              const EdgeInsets.all(12),

              color: Colors.teal.shade100,

              child: Text(
                'Item ${i + 1}',
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'GridView',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 200,

          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,

            children: List.generate(
              6,
                  (i) => Container(
                color: Colors.purple.shade100,
                alignment: Alignment.center,
                child: Text('${i + 1}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}