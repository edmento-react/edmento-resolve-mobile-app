import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentListWidget extends StatelessWidget {
  final List<EmailAttachment> attachments;
  final Function(String) onRemoveAttachment;

  const AttachmentListWidget({
    super.key,
    required this.attachments,
    required this.onRemoveAttachment,
  });

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments (${attachments.length})',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12.h),
          ...attachments.map((attachment) => _buildAttachmentItem(attachment)),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(EmailAttachment attachment) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          _buildFileIcon(attachment.mimeType),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  _formatFileSize(attachment.size),
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 18.sp, color: Colors.grey[600]),
            onPressed: () => onRemoveAttachment(attachment.id),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.all(4.w),
          ),
        ],
      ),
    );
  }

  Widget _buildFileIcon(String mimeType) {
    IconData iconData;
    Color iconColor;

    if (mimeType.startsWith('image/')) {
      iconData = Icons.image;
      iconColor = Colors.green;
    } else if (mimeType.startsWith('video/')) {
      iconData = Icons.videocam;
      iconColor = Colors.purple;
    } else if (mimeType.startsWith('audio/')) {
      iconData = Icons.audiotrack;
      iconColor = Colors.orange;
    } else if (mimeType.contains('pdf')) {
      iconData = Icons.picture_as_pdf;
      iconColor = Colors.red;
    } else if (mimeType.contains('word') || mimeType.contains('document')) {
      iconData = Icons.description;
      iconColor = Colors.blue;
    } else if (mimeType.contains('sheet') || mimeType.contains('excel')) {
      iconData = Icons.table_chart;
      iconColor = Colors.green;
    } else if (mimeType.contains('presentation') ||
        mimeType.contains('powerpoint')) {
      iconData = Icons.slideshow;
      iconColor = Colors.orange;
    } else if (mimeType.contains('zip') || mimeType.contains('archive')) {
      iconData = Icons.archive;
      iconColor = Colors.brown;
    } else {
      iconData = Icons.attach_file;
      iconColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Icon(iconData, size: 20.sp, color: iconColor),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }
}
