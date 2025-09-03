import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Left→Right order to match your final look.
const _days = ['Sat', 'Fri', 'Thu', 'Wed', 'Tue', 'Mon'];

typedef TimetableMap = Map<int, List<String>>;

class _TTColors {
  // Theme-based colors - will be resolved in build method
  static Color header(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withOpacity(0.2);
  static Color gridBorder(BuildContext context) =>
      Theme.of(context).dividerColor;
  static Color cellBg(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  static Color text(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;
  static Color textMuted(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
  static Color freeBg(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  // Selection colors
  static Color selectedBg(BuildContext context) =>
      Theme.of(context).colorScheme.primary.withOpacity(0.2);
  static Color selectedText(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  // Dynamic color cache for classes and divisions
  static final Map<String, Color> _colorCache = {};

  /// Get dynamic color for a class/division with 0.1 opacity background
  static Color getDivisionBackgroundColor(
    String division,
    BuildContext context,
  ) {
    if (division.trim().isEmpty || division.trim().toLowerCase() == 'free') {
      return Colors.transparent;
    }

    // Check if we already generated a color for this division
    if (_colorCache.containsKey(division)) {
      return _colorCache[division]!.withOpacity(0.1);
    }

    // Generate a new color based on the division text
    final color = _generateColorFromString(division, context);
    _colorCache[division] = color;

    return color.withOpacity(0.1);
  }

  /// Get the full opacity color for text (same color as background but full opacity)
  static Color getDivisionTextColor(String division, BuildContext context) {
    if (division.trim().isEmpty || division.trim().toLowerCase() == 'free') {
      return Colors.transparent;
    }

    // Return the cached color or generate new one
    if (_colorCache.containsKey(division)) {
      return _colorCache[division]!;
    }

    final color = _generateColorFromString(division, context);
    _colorCache[division] = color;

    return color;
  }

  /// Generate a consistent color from string hash
  static Color _generateColorFromString(String text, BuildContext context) {
    final hash = text.hashCode.abs();
    final colorScheme = Theme.of(context).colorScheme;

    // Predefined settled color palettes
    final List<Color> lightModeColors = [
      const Color(0xFF8B0000), // Dark Red
      const Color(0xFF800000), // Maroon
      const Color(0xFF4B0082), // Indigo
      const Color(0xFF2F4F4F), // Dark Slate Gray
      const Color(0xFF483D8B), // Dark Slate Blue
      const Color(0xFF228B22), // Forest Green
      const Color(0xFF8B4513), // Saddle Brown
      const Color(0xFF191970), // Midnight Blue
      const Color(0xFFB22222), // Fire Brick
    ];

    final List<Color> darkModeColors = [
      const Color(0xFFCD5C5C), // Indian Red (lighter red)
      const Color(0xFFB03060), // Light Maroon
      const Color(0xFF9370DB), // Medium Purple
      const Color(0xFF708090), // Slate Gray
      const Color(0xFF7B68EE), // Medium Slate Blue
      const Color(0xFF90EE90), // Light Green
      const Color(0xFFDEB887), // Burlywood (lighter brown)
      const Color(0xFF4169E1), // Royal Blue
      const Color(0xFFFA8072), // Salmon
    ];

    final colors = colorScheme.brightness == Brightness.dark
        ? darkModeColors
        : lightModeColors;
    final colorIndex = hash % colors.length;

    return colors[colorIndex];
  }

  /// Clear color cache (useful for testing or memory management)
  static void clearColorCache() {
    _colorCache.clear();
  }
}

/// FINAL LOOK timetable grid (days header vertical, period header on RIGHT).
///
/// Features:
/// - Selection-based highlighting: click a cell to highlight all cells with same data
/// - Default appearance: normal cells with theme-based text colors
/// - Selected cells get blue background and text
/// - Free periods are highlighted differently
/// - Theme-aware colors for headers and borders
class TimetableGrid extends StatefulWidget {
  const TimetableGrid({
    super.key,
    required this.data,
    this.periodCount = 8,
    this.periodLabel = 'Period',
    this.cornerRadius = 12,
    this.onCellTap,
  });

  final TimetableMap data; // dayIdx -> list of period labels
  final int periodCount; // usually 8
  final String periodLabel;
  final double cornerRadius;

  final void Function(int dayIndex, int periodIndex, String value)? onCellTap;

  @override
  State<TimetableGrid> createState() => _TimetableGridState();
}

class _TimetableGridState extends State<TimetableGrid> {
  String? _selectedData; // Currently selected cell data

  void _handleCellTap(int dayIndex, int periodIndex, String value) {
    setState(() {
      // If clicking the same data, deselect it
      if (_selectedData == value) {
        _selectedData = null;
      } else {
        // Otherwise, select the new data
        _selectedData = value;
      }
    });

    // Call the original onCellTap callback if provided
    widget.onCellTap?.call(dayIndex, periodIndex, value);
  }

  bool _isCellSelected(String data) {
    if (_selectedData == null ||
        data.trim().isEmpty ||
        data.trim().toLowerCase() == 'free') {
      return false;
    }
    return _selectedData == data;
  }

  @override
  Widget build(BuildContext context) {
    final border = TableBorder(
      borderRadius: BorderRadius.circular(10),
      horizontalInside: BorderSide(
        color: _TTColors.gridBorder(context),
        width: 1,
      ),
      verticalInside: BorderSide(
        color: _TTColors.gridBorder(context),
        width: 1,
      ),
      top: BorderSide(color: _TTColors.gridBorder(context), width: 1),
      left: BorderSide(color: _TTColors.gridBorder(context), width: 1),
      right: BorderSide(color: _TTColors.gridBorder(context), width: 1),
      bottom: BorderSide(color: _TTColors.gridBorder(context), width: 1),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // total columns = days + period column
        final totalColumns = _days.length + 1;
        final dynamicCellWidth = constraints.maxWidth / totalColumns;

        // distribute height across header + periods
        final dayHeaderHeight = constraints.maxHeight * 0.1; // 10% for header
        final dynamicCellHeight =
            (constraints.maxHeight - dayHeaderHeight) / widget.periodCount;

        return Table(
          defaultColumnWidth: FixedColumnWidth(dynamicCellWidth),
          border: border,
          children: [
            _buildTopHeaderRow(context, dynamicCellWidth, dayHeaderHeight),
            ...List.generate(
              widget.periodCount,
              (p) => _buildBodyRow(
                context,
                p,
                dynamicCellWidth,
                dynamicCellHeight,
              ),
            ),
          ],
        );
      },
    );
  }

  // --------- Headers ----------
  TableRow _buildTopHeaderRow(
    BuildContext context,
    double cellWidth,
    double headerHeight,
  ) {
    return TableRow(
      children: [
        ...List.generate(
          _days.length,
          (i) => _dayHeaderCell(_days[i], i, cellWidth, headerHeight, context),
        ),
        _topRightCorner(cellWidth, headerHeight), // right-side corner
      ],
    );
  }

  Widget _dayHeaderCell(
    String day,
    int index,
    double width,
    double height,
    BuildContext context,
  ) {
    final isFirst = index == 0;
    final isLast = index == _days.length - 1;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _TTColors.header(context),
        borderRadius: BorderRadius.only(
          topLeft: isFirst
              ? Radius.circular(widget.cornerRadius.r)
              : Radius.zero,
          // topRight: isLast
          //     ? Radius.circular(widget.cornerRadius.r)
          //     : Radius.zero,
        ),
      ),
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: 1, // vertical day text
        child: TextWidget.heading4(context: context, day),
      ),
    );
  }

  Widget _topRightCorner(double width, double height) {
    return Builder(
      builder: (context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _TTColors.header(context),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.cornerRadius.r),
          ),
        ),
      ),
    );
  }

  // --------- Rows ----------
  TableRow _buildBodyRow(
    BuildContext context,
    int periodIndex,
    double cellWidth,
    double cellHeight,
  ) {
    return TableRow(
      children: [
        ...List.generate(_days.length, (dayIdx) {
          final value = widget.data[dayIdx]?[periodIndex] ?? '';
          final isFree = value.trim().toLowerCase() == 'free';
          return _cell(
            label: value,
            isFree: isFree,
            height: cellHeight,
            width: cellWidth,
            onTap: () => _handleCellTap(dayIdx, periodIndex, value),
            context: context,
          );
        }),
        _periodHeaderCell(periodIndex, cellWidth, cellHeight, context),
      ],
    );
  }

  Widget _cell({
    required String label,
    required bool isFree,
    required double width,
    required double height,
    VoidCallback? onTap,
    required BuildContext context,
  }) {
    final isSelected = _isCellSelected(label);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        color: isSelected
            ? _TTColors.getDivisionBackgroundColor(
                label,
                context,
              ).withOpacity(0.1)
            : _TTColors.cellBg(context),
        alignment: Alignment.center,
        child: RotatedBox(
          quarterTurns: 1,
          child: TextWidget.caption(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            label,
            textAlign: TextAlign.center,
            context: context,
            color: isFree
                ? _TTColors.textMuted(context)
                : isSelected
                ? _TTColors.getDivisionTextColor(label, context)
                : _TTColors.text(context),
          ),
        ),
      ),
    );
  }

  Widget _periodHeaderCell(
    int periodIndex,
    double width,
    double height,
    BuildContext context,
  ) {
    final isLast = periodIndex == widget.periodCount - 1;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _TTColors.header(context),
        borderRadius: BorderRadius.only(
          bottomRight: isLast
              ? Radius.circular(widget.cornerRadius.r)
              : Radius.zero,
        ),
      ),
      alignment: Alignment.center,
      child: RotatedBox(
        quarterTurns: 1,
        child: TextWidget.heading4(context: context, ' ${periodIndex + 1}'),
      ),
    );
  }
}
