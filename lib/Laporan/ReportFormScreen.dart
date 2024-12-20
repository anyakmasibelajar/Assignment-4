import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/Laporan/MyReportScreen.dart'; // Pastikan halaman MyReportScreen diimport

class ReportFormScreen extends StatefulWidget {
  final String? reportId; // Untuk mengedit laporan
  final String? title;
  final String? description;
  final String? location;
  final String? imageUrl;

  ReportFormScreen({
    this.reportId,
    this.title,
    this.description,
    this.location,
    this.imageUrl,
  });

  @override
  _ReportFormScreenState createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  File? _image;
  bool _isUploading = false;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Isi form jika mengedit laporan
    if (widget.reportId != null) {
      _titleController.text = widget.title ?? '';
      _descriptionController.text = widget.description ?? '';
      _locationController.text = widget.location ?? '';
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Sumber Gambar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _locationController.text.isEmpty ||
        (_image == null && widget.reportId == null)) {
      Get.snackbar('Error', 'Please complete all fields and select an image');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final data = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'timestamp': Timestamp.now(),
      };

      if (widget.reportId == null) {
        // Menambahkan laporan baru
        await FirebaseFirestore.instance.collection('reports').add(data);
        Get.snackbar('Success', 'Laporan berhasil dikirim');
      } else {
        // Mengedit laporan yang sudah ada
        await FirebaseFirestore.instance.collection('reports').doc(widget.reportId).update(data);
        Get.snackbar('Success', 'Laporan berhasil diperbarui');
      }

      // Simpan data ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_report', data.toString());

      // Arahkan pengguna ke halaman laporan saya
      Get.to(() => MyReportScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit report: $e');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.reportId == null ? 'Isi Laporan' : 'Edit Laporan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(83, 127, 232, 1),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.reportId == null ? 'Lengkapi Informasi Laporan' : 'Edit Laporan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(83, 127, 232, 1),
              ),
            ),
            SizedBox(height: 16),
            _buildInputSection(
              label: 'Judul',
              controller: _titleController,
              hintText: 'Masukkan judul singkat laporan',
            ),
            SizedBox(height: 16),
            _buildInputSection(
              label: 'Deskripsi',
              controller: _descriptionController,
              hintText: 'Deskripsikan masalah yang ingin dilaporkan',
              maxLines: 4,
            ),
            SizedBox(height: 16),
            _buildInputSection(
              label: 'Lokasi',
              controller: _locationController,
              hintText: 'Masukkan lokasi terjadinya masalah',
            ),
            SizedBox(height: 16),
            Text(
              'Foto Bukti',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8),
            _image == null && widget.imageUrl == null
                ? Text(
                    'No image selected',
                    style: TextStyle(color: Colors.black54),
                  )
                : Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _image!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showImageSourceDialog,
              icon: Icon(Icons.add_a_photo, color: Colors.white),
              label: Text('Tambahkan Foto', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(83, 127, 231, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isUploading
          ? CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: _submitReport,
              child: Icon(Icons.send, color: Colors.white),
              backgroundColor: const Color.fromRGBO(83, 127, 231, 1),
            ),
    );
  }

  Widget _buildInputSection({
    required String label,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: const Color.fromRGBO(83, 127, 232, 1)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
