import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class StudentPrizes extends StatefulWidget {
  const StudentPrizes({super.key});

  @override
  State<StudentPrizes> createState() => _StudentPrizesState();
}

class _StudentPrizesState extends State<StudentPrizes>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _students = [
    {"name": "Mahmoud Dabbora", "collected": false},
    {"name": "Ahmed Said", "collected": false},
    {"name": "Ali Hassan", "collected": false},
    {"name": "Fatima Zahra", "collected": true},
    {"name": "Layla Khaled", "collected": true},
  ];

  late List<bool> _isExpandedList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _isExpandedList = List<bool>.filled(_students.length, false);
  }

  Widget _buildPrizeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Completed a story test with an evaluation Very Good!"),
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/studentScore.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text("Score: 3"),
          ],
        ),
        const SizedBox(height: 20), // مسافة كبيرة بين النص والرقم كما طلبت
        Row(
          children: [
            Image.asset('assets/images/golden.png', width: 24, height: 24),
            const SizedBox(width: 8),
            const Text("Golden cards: 0"),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Image.asset('assets/images/silver.png', width: 24, height: 24),
            const SizedBox(width: 8),
            const Text("Silver cards: 0"),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Image.asset('assets/images/bronze.png', width: 24, height: 24),
            const SizedBox(width: 8),
            const Text("Bronze cards: 1"),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final uncollected = _students.where((s) => !s["collected"]).toList();
    final collected = _students.where((s) => s["collected"]).toList();

    Widget buildList(List<Map<String, dynamic>> list) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          final student = list[i];
          final index = _students.indexOf(student);

          return ExpansionTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(student["name"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!student["collected"])
                  Checkbox(
                    value: false,
                    onChanged: (_) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Collect Prize',
                        desc: 'Mark "${student["name"]}" as collected?',
                        btnCancelText: "No",
                        btnOkText: "Yes",
                        btnOkOnPress: () {
                          setState(() {
                            student["collected"] = true;
                            // Reset expansion for moved item (optional)
                            _isExpandedList[index] = false;
                          });
                          _tabController.animateTo(1);
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    },
                  ),
                const Icon(Icons.expand_more),
              ],
            ),
            backgroundColor: _isExpandedList[index]
                ? const Color.fromARGB(255, 127, 243, 131)
                : Colors.transparent,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpandedList[index] = expanded;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _buildPrizeDetails(),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Prizes"),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // لون نص التبويب النشط أبيض
          unselectedLabelColor:
              Colors.white70, // نص التبويب غير النشط أبيض شفاف
          tabs: const [
            Tab(text: "UnCollected"),
            Tab(text: "Collected"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [buildList(uncollected), buildList(collected)],
      ),
    );
  }
}
