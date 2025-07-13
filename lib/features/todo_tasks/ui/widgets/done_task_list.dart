import 'package:english_club/features/todo_tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/shimmer_loading.dart'; // استيراد ShimmerLoading و TaskCardShimmer من ملفهما

class DoneTaskList extends StatelessWidget {
  final List<DoneData> tasks;
  final ScrollController scrollController;
  final bool hasMoreData;
  final bool isLoadingMore;

  const DoneTaskList({
    Key? key,
    required this.tasks,
    required this.scrollController,
    required this.hasMoreData,
    this.isLoadingMore = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: tasks.length + (hasMoreData && isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == tasks.length && hasMoreData && isLoadingMore) {
          // 🔄 عرض ShimmerLoading بدلاً من CircularProgressIndicator
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ShimmerLoading(
              child:
                  TaskCardShimmer(), // استخدام TaskCardShimmer لإنشاء تأثير الشيمر
            ),
          );
        }
        final task = tasks[index];
        return TaskCard(task: task, isWaitingList: false, onChanged: null);
      },
    );
  }
}
