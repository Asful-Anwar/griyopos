import 'package:flutter/material.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fitur = [
      {'icon': Icons.category, 'label': 'Jenis Usaha'},
      {'icon': Icons.store, 'label': 'Lokasi Usaha'},
      {'icon': Icons.people, 'label': 'Karyawan'},
      {'icon': Icons.person, 'label': 'Pengguna'},
      {'icon': Icons.business, 'label': 'Cabang'},
      {'icon': Icons.settings, 'label': 'Pengaturan'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Master"),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: fitur.map((fiturItem) {
            return GestureDetector(
              onTap: () {
                // TODO: Navigasi ke halaman masing-masing fitur
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(fiturItem['icon'], size: 48, color: Colors.blue),
                      SizedBox(height: 10),
                      Text(
                        fiturItem['label'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
