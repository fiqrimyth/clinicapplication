import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseDateScreen extends StatefulWidget {
  const ChooseDateScreen({super.key});

  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int? _selectedScheduleIndex;

  // Dummy data untuk schedule
  final List<Map<String, dynamic>> _dummySchedules = [
    {
      'day': 'Jum\'at',
      'date': '20 November 2021',
      'startTime': '13:00',
      'endTime': '15:00',
    },
    {
      'day': 'Rabu',
      'date': '25 November 2021',
      'startTime': '14:00',
      'endTime': '16:00',
    },
    {
      'day': 'Rabu',
      'date': '2 December 2021',
      'startTime': '14:00',
      'endTime': '16:00',
    },
    {
      'day': 'Jum\'at',
      'date': '4 December 2021',
      'startTime': '13:00',
      'endTime': '15:00',
    },
  ];

  /* TODO: Implementasi data dari API
  List<Schedule> _schedules = [];
  bool _isLoading = false;

  Future<void> _fetchSchedules() async {
    setState(() => _isLoading = true);
    try {
      // final response = await ApiService().getSchedules();
      // _schedules = response;
    } catch (e) {
      // Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child:
                Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey[800]),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Choose Date',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F1F1F),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Schedule depends on doctor\'s availability',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 60)),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: CalendarFormat.month,
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFF617BF4),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: const Color(0xFF617BF4).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _dummySchedules.length,
                      itemBuilder: (context, index) {
                        final schedule = _dummySchedules[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedScheduleIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FE),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedScheduleIndex == index
                                      ? const Color(0xFF617BF4)
                                      : Colors.transparent,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${schedule['day']}, ${schedule['date']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${schedule['startTime']} - ${schedule['endTime']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Radio(
                                    value: index,
                                    groupValue: _selectedScheduleIndex,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedScheduleIndex = value;
                                      });
                                    },
                                    activeColor: const Color(0xFF617BF4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedScheduleIndex != null
                ? () {
                    // Handle next action
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF617BF4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
