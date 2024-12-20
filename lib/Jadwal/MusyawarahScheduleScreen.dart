import 'package:flutter/material.dart';

class MusyawarahScheduleScreen extends StatelessWidget {
  // Daftar jadwal musyawarah
  final List<Map<String, String>> schedules = [
    {
      'date': '12 November 2024',
      'time': '10:00 AM',
      'location': 'Rumah Pak RT',
      'topic': 'Musyawarah Pemilihan Ketua'
    },
    {
      'date': '15 November 2024',
      'time': '01:00 PM',
      'location': 'Aula Desa',
      'topic': 'Musyawarah Pembangunan Infrastruktur'
    },
    {
      'date': '20 November 2024',
      'time': '09:00 AM',
      'location': 'Balai Pertemuan Umum',
      'topic': 'Musyawarah Pengembangan Pendidikan'
    },
    {
      'date': '25 November 2024',
      'time': '03:00 PM',
      'location': 'Rumah Pak RT',
      'topic': 'Musyawarah Pengelolaan Sampah'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Musyawarah',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(83, 127, 232, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule['topic']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: const Color.fromRGBO(83, 127, 232, 1)),
                    SizedBox(width: 8.0),
                    Text(schedule['date']!, style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.access_time, color: const Color.fromRGBO(83, 127, 232, 1)),
                    SizedBox(width: 8.0),
                    Text(schedule['time']!, style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.location_on, color: const Color.fromRGBO(83, 127, 232, 1)),
                    SizedBox(width: 8.0),
                    Text(schedule['location']!, style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Color.fromARGB(255, 235, 246, 255),
    );
  }
}
