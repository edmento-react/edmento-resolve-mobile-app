import 'package:cached_network_image/cached_network_image.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/teacher/domain/entities/task.dart';
import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  final List<TaskAssignee> users;
  final double size;
  final double overlap;

  const AvatarStack({
    super.key,
    required this.users,
    this.size = 28,
    this.overlap = 10,
  });

  @override
  Widget build(BuildContext context) {
    final shown = users.take(3).toList(); // show up to 3 like the mock
    return SizedBox(
      height: size,
      width: (shown.length * (size - overlap)) + overlap,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              right: i * (size - overlap),
              child: _Avatar(size: size, user: shown[i]),
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final double size;
  final TaskAssignee user;

  const _Avatar({required this.size, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: user.avatarUrl != null
            ? CachedNetworkImage(imageUrl: user.avatarUrl!, fit: BoxFit.cover)
            : Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: TextWidget.heading4(
                  user.name.isNotEmpty ? user.name[0] : '?',
                  context: context,
                ),
              ),
      ),
    );
  }
}
