import 'package:flutter/material.dart';
import 'package:myapp/Laporan/Laporan.dart';
import 'package:myapp/Laporan/ReportFormScreen.dart';
import 'package:myapp/Laporan/MyReportScreen.dart'; // Pastikan MyReportScreen diimpor

class LaporPage extends StatefulWidget {
  @override
  _LaporPageState createState() => _LaporPageState();
}

class _LaporPageState extends State<LaporPage> {
  final List<Laporan> laporanList = [
    Laporan(
      kategori: 'Arus Lalu Lintas',
      deskripsi: 'Macet parah, sudah 1 jam tidak bergerak sama sekali',
      lokasi: 'Suhat',
      waktu: '3 November 2024',
      fotoUrl: 'assets/macet.jpg',
    ),
    Laporan(
      kategori: 'Kondisi Jalanan',
      deskripsi: 'Kondisi jalanan di dekat rel kereta api sangat rusak',
      lokasi: 'Blimbing',
      waktu: '1 November 2024',
      fotoUrl: 'assets/jalan.jpg',
    ),
    Laporan(
      kategori: 'Coretan Liar',
      deskripsi: 'Dinding ruko depan rumah saya terlihat tidak estetik',
      lokasi: 'Jl. Hamid Rusdi',
      waktu: '31 Oktober 2024',
      fotoUrl: 'assets/dinding.jpeg',
    ),
  ];

  List<Laporan> filteredList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = laporanList;
    searchController.addListener(_filterLaporan);
  }

  void _filterLaporan() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredList = laporanList
          .where((laporan) =>
              laporan.deskripsi.toLowerCase().contains(query) ||
              laporan.kategori.toLowerCase().contains(query) ||
              laporan.lokasi.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterLaporan);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Laporan Warga',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          TextButton(
            onPressed: () {
              // Arahkan pengguna ke MyReportScreen saat tombol 'Laporan Saya' diklik
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyReportScreen()),
              );
            },
            child: Text(
              'Laporan Saya',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari laporan',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Color.fromARGB(255, 235, 246, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final laporan = filteredList[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Foto di atas
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage(laporan.fotoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Konten Laporan
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              laporan.deskripsi,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text('${laporan.kategori} - ${laporan.lokasi}'),
                            Text(laporan.waktu),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportFormScreen()),
          );
        },
        child: ClipOval(
          child: Image.asset(
            'assets/add.png',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: const Color.fromRGBO(83, 127, 231, 1),
        shape: CircleBorder(),
        elevation: 0,
      ),
    );
  }
}


