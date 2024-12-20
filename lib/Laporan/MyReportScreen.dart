import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:myapp/Laporan/ReportFormScreen.dart'; // Pastikan halaman ReportFormScreen diimport

class MyReportScreen extends StatefulWidget {
  @override
  _MyReportScreenState createState() => _MyReportScreenState();
}

class _MyReportScreenState extends State<MyReportScreen> {
  Map<String, dynamic>? _localReport;

  @override
  void initState() {
    super.initState();
    _loadLocalReport();
  }

  Future<void> _loadLocalReport() async {
    final prefs = await SharedPreferences.getInstance();
    final reportString = prefs.getString('last_report');
    if (reportString != null) {
      setState(() {
        _localReport = json.decode(reportString);
      });
    }
  }

  Future<void> _deleteReport(String reportId) async {
    try {
      await FirebaseFirestore.instance.collection('reports').doc(reportId).delete();
      Get.snackbar('Berhasil', 'Laporan berhasil dihapus.', backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Gagal', 'Gagal menghapus laporan.', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Saya',
          style: TextStyle(
            color: Colors.white, // Warna teks putih
            fontWeight: FontWeight.bold, // Cetak tebal
          ),
        ),
        backgroundColor: const Color.fromRGBO(83, 127, 232, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Warna panah putih
          onPressed: () {
            Get.back(); // Menutup halaman saat tombol kembali ditekan
          },
        ),
      ),
      backgroundColor: Colors.white, // Mengubah latar belakang menjadi putih
      body: Column(
        children: [
          if (_localReport != null) _buildLocalReportSection(),
          Expanded(child: _buildFirestoreReportsSection()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ReportFormScreen());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromRGBO(83, 127, 232, 1),
      ),
    );
  }

  Widget _buildLocalReportSection() {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Laporan Terakhir (Lokal)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Judul: ${_localReport?['title'] ?? '-'}'),
            Text('Deskripsi: ${_localReport?['description'] ?? '-'}'),
            Text('Lokasi: ${_localReport?['location'] ?? '-'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildFirestoreReportsSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('reports').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Belum ada laporan.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final report = snapshot.data!.docs[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(report['title']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deskripsi: ${report['description']}'),
                    Text('Lokasi: ${report['location']}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.to(() => ReportFormScreen(
                              reportId: report.id,
                              title: report['title'],
                              description: report['description'],
                              location: report['location'],
                            ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteReport(report.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Formulir untuk menambahkan/edit laporan
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        filled: true, // Isi latar belakang dengan warna
        fillColor: Colors.white, // Warna latar belakang putih
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1), // Border tipis dengan warna biru
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2), // Border saat fokus dengan ketebalan lebih
        ),
      ),
    );
  }
}
