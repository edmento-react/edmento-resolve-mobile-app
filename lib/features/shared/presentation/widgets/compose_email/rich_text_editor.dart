import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RichTextEditor extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hintText;

  const RichTextEditor({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText,
  });

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _showFormatting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showFormatting) _buildFormattingToolbar(),
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Compose your message...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
              fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
              decoration: _isUnderline
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            onChanged: widget.onChanged,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
        _buildBottomToolbar(),
      ],
    );
  }

  Widget _buildFormattingToolbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          _buildFormatButton(
            icon: Icons.format_bold,
            isSelected: _isBold,
            onTap: () {
              setState(() {
                _isBold = !_isBold;
              });
            },
          ),
          SizedBox(width: 8.w),
          _buildFormatButton(
            icon: Icons.format_italic,
            isSelected: _isItalic,
            onTap: () {
              setState(() {
                _isItalic = !_isItalic;
              });
            },
          ),
          SizedBox(width: 8.w),
          _buildFormatButton(
            icon: Icons.format_underlined,
            isSelected: _isUnderline,
            onTap: () {
              setState(() {
                _isUnderline = !_isUnderline;
              });
            },
          ),
          SizedBox(width: 8.w),
          _buildFormatButton(
            icon: Icons.format_list_bulleted,
            isSelected: false,
            onTap: () {
              // TODO: Implement bullet list
            },
          ),
          SizedBox(width: 8.w),
          _buildFormatButton(
            icon: Icons.format_list_numbered,
            isSelected: false,
            onTap: () {
              // TODO: Implement numbered list
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isSelected ? Colors.blue[700] : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: 0.5)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _showFormatting
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 20.sp,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _showFormatting = !_showFormatting;
              });
            },
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(Icons.attach_file, size: 20.sp, color: Colors.grey[600]),
            onPressed: () {
              // TODO: Implement file attachment
            },
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(
              Icons.insert_emoticon,
              size: 20.sp,
              color: Colors.grey[600],
            ),
            onPressed: () {
              // TODO: Implement emoji picker
            },
          ),
          const Spacer(),
          Text(
            '${widget.controller.text.length} characters',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
