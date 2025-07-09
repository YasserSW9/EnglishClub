// lib/features/prizes/ui/widgets/prize_avatar.dart
import 'package:english_club/features/student_prizes/ui/widgets/shimmer_loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrizeAvatar extends StatelessWidget {
  final String? profilePictureUrl;

  const PrizeAvatar({super.key, this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    final bool hasValidImageUrl =
        profilePictureUrl != null && profilePictureUrl!.isNotEmpty;

    Widget avatarContent;

    if (hasValidImageUrl) {
      avatarContent = Image.network(
        profilePictureUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint(
            'Image.network Error for URL: $profilePictureUrl Error: $error',
          );
          return const Icon(Icons.person, color: Colors.white);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ShimmerLoadingWidgets.buildShimmerAvatar();
        },
      );
    } else {
      avatarContent = const Icon(Icons.person, color: Colors.white);
    }

    return CircleAvatar(
      backgroundColor: Colors.orange,
      child: ClipOval(
        child: SizedBox(width: 48.w, height: 48.h, child: avatarContent),
      ),
    );
  }
}
