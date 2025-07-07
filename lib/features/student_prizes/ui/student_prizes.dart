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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // To display prize details
  void _showPrizeDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 216, 149, 210),
        title: const Text("Reason"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Completed a story test with an evaluation Very Good!"),
            const SizedBox(height: 10),
            _buildPrizeRow("Score", 3, Icons.sunny),
            _buildPrizeRow("Golden cards", 0, Icons.star),
            _buildPrizeRow("Silver cards", 0, Icons.star_half),
            _buildPrizeRow("Bronze cards", 1, Icons.stars),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // To build a prize detail row within the dialog
  Widget _buildPrizeRow(String label, int count, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
        Text("$count"),
      ],
    );
  }

  // Builds a student list tile
  Widget _buildStudentItem(BuildContext context, Map<String, dynamic> student) {
    final String name = student["name"];
    bool collected = student["collected"];

    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!collected) // Show Checkbox only if the prize is uncollected
            Checkbox(
              value: collected,
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Collect Prize',
                    desc:
                        'Are you sure you want to mark "${name}"\'s prize as collected?',
                    btnCancelText: "No",
                    btnOkText: "Yes",
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      setState(() {
                        // Find the student in the original list and update their collected status
                        final int studentIndex = _students.indexOf(student);
                        if (studentIndex != -1) {
                          _students[studentIndex]["collected"] = true;
                        }
                      });
                      // After updating the state, switch to the "Collected" tab
                      _tabController.animateTo(
                        1,
                      ); // 1 is the index for "Collected" tab
                    },
                  ).show();
                }
              },
            ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        ],
      ),
      onTap: () => _showPrizeDetails(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter students directly within the build method, it's efficient enough for small lists
    final List<Map<String, dynamic>> uncollectedStudents = _students
        .where((s) => s["collected"] == false)
        .toList();
    final List<Map<String, dynamic>> collectedStudents = _students
        .where((s) => s["collected"] == true)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Prizes"),
        backgroundColor: const Color(0xFF673AB7),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // Set selected tab text color to white
          unselectedLabelColor: Colors
              .white70, // Set unselected tab text color to a lighter white
          indicatorColor: Colors.white, // Optional: for the indicator line
          tabs: const [
            Tab(text: "UnCollected"),
            Tab(text: "Collected"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // List of uncollected students
          ListView.builder(
            itemCount: uncollectedStudents.length,
            itemBuilder: (context, idx) {
              return _buildStudentItem(context, uncollectedStudents[idx]);
            },
          ),
          // List of collected students
          ListView.builder(
            itemCount: collectedStudents.length,
            itemBuilder: (context, idx) {
              return _buildStudentItem(context, collectedStudents[idx]);
            },
          ),
        ],
      ),
    );
  }
}
