import 'package:clinicapplication/screen/menu/clinic/detail/doctor_detail_screen.dart';
import 'package:clinicapplication/screen/menu/clinic/widget/doctor_card.dart';
import 'package:flutter/material.dart';

class ClinicScreen extends StatefulWidget {
  const ClinicScreen({super.key});

  @override
  State<ClinicScreen> createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  // State untuk menyimpan pilihan yang aktif
  String _activeSort = 'Most Suitable';
  String _activeLocation = 'DKI Jakarta';
  int _activeRating = 5;

  // List untuk data filter
  final List<String> sortOptions = [
    'Most Suitable',
    'Popular',
    'Newest',
    'Nearest',
    'Available'
  ];

  List<String> locationOptions = [
    'DKI Jakarta',
    'Tangerang',
    'Bekasi',
    'Bandung',
    'Jabodetabek',
    'Depok'
  ];

  // Bottom sheet untuk See All Location
  void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.75,
          expand: false,
          builder: (context, scrollController) => _buildLocationContent(
            context,
            scrollController,
            setState,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationContent(
    BuildContext context,
    ScrollController scrollController,
    StateSetter setModalState,
  ) {
    return Column(
      children: [
        // Bagian Statis (Header & Search)
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBottomSheetIndicator(),
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Search Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),

        // Bagian Scrollable (List Locations)
        Expanded(
          child: FutureBuilder<List<String>>(
            future: getLocations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final locations = snapshot.data ?? [];

              return ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: locations.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[200],
                  height: 1,
                ),
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey[600],
                  ),
                  title: Text(
                    locations[index],
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    _updateLocationSelection(locations[index]);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.75,
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: _buildFilterContent(context, setModalState),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context, StateSetter setModalState) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetIndicator(),
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildSortSection(setModalState),
          const SizedBox(height: 24),
          _buildLocationSection(context, setModalState),
          const SizedBox(height: 24),
          _buildRatingSection(setModalState),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBottomSheetIndicator() {
    return Center(
      child: Container(
        width: 32,
        height: 4,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildSortSection(StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sortOptions
              .map((sort) => _buildFilterChip(
                    label: sort,
                    isActive: _activeSort == sort,
                    onTap: () => setModalState(() => _activeSort = sort),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildLocationSection(
      BuildContext context, StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => _showLocationBottomSheet(context),
              child: const Text(
                'See All',
                style: TextStyle(color: Color(0xFF4F46E5)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: locationOptions
              .map((location) => _buildFilterChip(
                    label: location,
                    isActive: _activeLocation == location,
                    onTap: () =>
                        setModalState(() => _activeLocation = location),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRatingSection(StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: List.generate(5, (index) {
            final rating = 5 - index;
            return _buildRatingChip(
              rating: rating,
              isActive: _activeRating == rating,
              onTap: () => setModalState(() => _activeRating = rating),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF4F46E5).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF4F46E5) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF4F46E5) : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingChip({
    required int rating,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF4F46E5).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF4F46E5) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: Color(0xFFFF9500),
            ),
            const SizedBox(width: 4),
            Text(
              rating.toString(),
              style: TextStyle(
                color: isActive ? const Color(0xFF4F46E5) : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateLocationSelection(String location) {
    setState(() {
      _activeLocation = location;
      if (!locationOptions.contains(location)) {
        locationOptions.insert(0, location);
        if (locationOptions.length > 6) {
          locationOptions.removeLast();
        }
      } else {
        locationOptions.remove(location);
        locationOptions.insert(0, location);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Clinic',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Color(0xFF1F2937),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Dropdown dan Setting Icon dalam satu Row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => StatefulBuilder(
                          builder: (context, setState) =>
                              DraggableScrollableSheet(
                            initialChildSize: 0.75,
                            minChildSize: 0.5,
                            maxChildSize: 0.75,
                            expand: false,
                            builder: (context, scrollController) => Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 24, 24, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        'Choose Specialist',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              // Filter listview berdasarkan input
                                              [
                                                'Spesialis Umum',
                                                'Spesialis Penyakit Dalam',
                                                'Spesialis Anak',
                                                'Spesialis Saraf',
                                                'Spesialis Kandungan',
                                                'Spesialis Bedah',
                                                'Spesialis Kulit & Kelamin',
                                                'Spesialis THT'
                                              ]
                                                  .where((specialist) =>
                                                      specialist
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase()))
                                                  .toList();

                                              // Update listview dengan hasil filter
                                              // TODO: Implement update listview
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.search,
                                                color: Colors.grey[600]),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: ListView(
                                    controller: scrollController,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    children: [
                                      _buildSpecialistItem('Spesialis Umum'),
                                      _buildSpecialistItem(
                                          'Spesialis Penyakit Dalam'),
                                      _buildSpecialistItem('Spesialis Anak'),
                                      _buildSpecialistItem('Spesialis Saraf'),
                                      _buildSpecialistItem(
                                          'Spesialis Kandungan'),
                                      _buildSpecialistItem('Spesialis Bedah'),
                                      _buildSpecialistItem(
                                          'Spesialis Kulit & Kelamin'),
                                      _buildSpecialistItem('Spesialis THT'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Choose Specialist',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1F2937),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    _showFilterBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF4F46E5),
                        width: 1,
                      ),
                    ),
                    child: Image.asset(
                      'assets/icon/linear/setting.png',
                      width: 24,
                      height: 24,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),
                ),
              ],
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DoctorDetailScreen(doctor: doctor),
                      ),
                    );
                  },
                  child: DoctorCard(doctor: doctor),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialistItem(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Icon(
            Icons.person_outline,
            color: Colors.grey[600],
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: () {},
      ),
    );
  }
}

// Fungsi untuk mendapatkan data lokasi dari API (dinonaktifkan sementara)
// Future<List<String>> getLocations() async {
//   try {
//     // TODO: Implement actual API call
//     // final response = await http.get(Uri.parse('API_URL_HERE'));
//     // if (response.statusCode == 200) {
//     //   final List<dynamic> data = json.decode(response.body);
//     //   return data.map((e) => e.toString()).toList();
//     // }
//     // throw Exception('Failed to load locations');
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }

// Fungsi sementara untuk data dummy
Future<List<String>> getLocations() async {
  // Simulasi network delay
  await Future.delayed(const Duration(seconds: 1));

  return [
    'DKI Jakarta',
    'Tangerang',
    'Bekasi',
    'Bandung',
    'Jabodetabek',
    'Depok',
    'Bogor',
    'Surabaya',
    'Semarang',
    'Yogyakarta',
    'Malang',
    'Medan'
  ];
}
