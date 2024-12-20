import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementScreen extends StatefulWidget {
  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> filteredAnnouncements = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterAnnouncements);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterAnnouncements);
    searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk memfilter pengumuman
  void _filterAnnouncements() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredAnnouncements = filteredAnnouncements.where((announcement) {
        String title = announcement['title'] ?? '';
        String description = announcement['description'] ?? '';
        return title.toLowerCase().contains(query) || description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengumuman',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari Pengumuman',
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
            child: StreamBuilder(
  stream: FirebaseFirestore.instance.collection('announcements').snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text("Belum ada pengumuman"));
    }

    final announcements = snapshot.data!.docs;

    // Memfilter pengumuman berdasarkan pencarian
    filteredAnnouncements = announcements;

    return ListView.builder(
      itemCount: filteredAnnouncements.length,
      itemBuilder: (context, index) {
        final announcement = filteredAnnouncements[index];

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
              // Jika ada gambar pengumuman, tampilkan gambar
              announcement['imageUrl'] != null
                  ? Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(announcement['imageUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 160,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(
                          'No image available',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
              // Konten Pengumuman
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement['title'] ?? 'No title',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      announcement['description'] ?? 'No description',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      announcement['timestamp'] ?? 'No timestamp',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  },
),

          ),
        ],
      ),
    );
  }
}
