import 'package:clinicapplication/screen/menu/clinic/model/doctor.dart';
import 'package:flutter/material.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Specialist
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Choose Specialist',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Popular Doctors Text
            const Text(
              'Popular Doctors',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // List Doctors
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doctorsList.length,
              itemBuilder: (context, index) {
                final doctor = doctorsList[index];
                return DoctorCard(doctor: doctor);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Card Dokter
class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Foto Dokter
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(doctor.imageUrl),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Informasi Dokter
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          doctor.hospital,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialist,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(doctor.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),

            // Bookmark Button
            IconButton(
              icon: const Icon(Icons.bookmark_outline),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

final List<Doctor> doctorsList = [
  Doctor(
    name: 'Salsabila Sp.PD',
    specialist: 'Spesialis Penyakit Dalam',
    hospital: 'RSUD Tebet, Tebet',
    imageUrl: 'https://example.com/doctor1.jpg',
    rating: 4.9,
    description:
        'Dokter spesialis penyakit dalam dengan pengalaman lebih dari 10 tahun',
    locationMapUrl: 'https://maps.google.com/location1',
    excellentCount: 150,
    goodCount: 80,
    averageCount: 20,
    badCount: 5,
    tooBadCount: 2,
    experiences: [
      Experience(
          position: 'Dokter Spesialis Penyakit Dalam', hospital: 'RSUD Tebet'),
      Experience(position: 'Dokter Umum', hospital: 'Klinik Sehat Tebet')
    ],
    consultationPrice: 150000,
    reviews: [], // Added required reviews parameter
  ),
  Doctor(
    name: 'Sulistyaningsih Sp.A',
    specialist: 'Spesialis Anak',
    hospital: 'RS Menteng Mitra Afia, Menteng',
    imageUrl: 'https://example.com/doctor2.jpg',
    rating: 4.5,
    description: 'Dokter spesialis anak yang ramah dan berpengalaman',
    locationMapUrl: 'https://maps.google.com/location2',
    excellentCount: 120,
    goodCount: 90,
    averageCount: 30,
    badCount: 8,
    tooBadCount: 3,
    experiences: [
      Experience(
          position: 'Dokter Spesialis Anak', hospital: 'RS Menteng Mitra Afia'),
      Experience(position: 'Dokter Umum', hospital: 'Klinik Sehat Menteng')
    ],
    consultationPrice: 200000,
    reviews: [], // Added required reviews parameter
  ),
];
