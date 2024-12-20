import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String reportId;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final String timestamp; 
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ReportCard({
    required this.reportId,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.timestamp,  
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Foto di atas
          imageUrl.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 120,  // Mengurangi tinggi gambar menjadi lebih pendek
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 120,  // Mengurangi tinggi gambar saat tidak ada gambar
                  color: Colors.grey[200],
                  child: Center(
                    child: Text(
                      'No image available',
                      style: TextStyle(color: const Color.fromARGB(137, 0, 0, 0)),
                    ),
                  ),
                ),
          // Konten Laporan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Mengurangi padding vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Deskripsi laporan
                Text(
                  description,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 2, // Membatasi deskripsi agar tidak terlalu panjang
                  overflow: TextOverflow.ellipsis, // Memotong jika deskripsi terlalu panjang
                ),
                SizedBox(height: 4), // Mengurangi jarak
                Text(
                  '$title - $location',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                // Tanggal laporan
                Text(
                  '$timestamp',  // Menampilkan tanggal yang sudah diformat
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                // Tombol edit dan hapus dengan teks
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onEdit,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: const Color.fromRGBO(83, 127, 231, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: onDelete,
                      child: Text(
                        'Hapus',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
