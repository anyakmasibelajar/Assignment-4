import 'package:flutter/material.dart';
import 'package:myapp/Galeri/GalleryDetailScreen.dart';

class GalleryScreen extends StatelessWidget {
  // Daftar gambar statis untuk galeri
  final List<Map<String, String>> galleryItems = [
    {
      'imageUrl': 'https://kominfo.kotabogor.go.id/asset/images/web/IMAGES/Musyawarah%20Daerah%20III%20APKOMINDO%20DPD%20BOGOR.jpg', 
      'title': 'Acara Musyawarah',
      'description': 'Foto acara musyawarah di aula desa.',
    },
    {
      'imageUrl': 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/radarmalang/2021/11/pasar-blimbing.jpg',
      'title': 'Perbaikan Jalan',
      'description': 'Foto dokumentasi perbaikan jalan di lingkungan desa.',
    },
    {
      'imageUrl': 'https://mahasiswaindonesia.id/wp-content/uploads/2024/08/Picture1a.jpg',
      'title': 'Penyuluhan Kesehatan',
      'description': 'Kegiatan penyuluhan kesehatan untuk warga.',
    },
    {
      'imageUrl': 'https://cdn.antaranews.com/cache/1200x800/2023/01/27/panen-raya.jpg.webp',
      'title': 'Panen Raya',
      'description': 'Foto panen raya bersama warga desa.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galeri Kita',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(83, 127, 232, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 235, 246, 255),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: galleryItems.length,
        itemBuilder: (context, index) {
          final item = galleryItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryDetailScreen(
                    imageUrl: item['imageUrl']!,
                    title: item['title']!,
                    description: item['description']!,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                      child: Image.network(
                        item['imageUrl']!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
