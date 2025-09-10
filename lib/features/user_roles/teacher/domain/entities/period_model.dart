class Period {
  final String schedules;
  final String timeBlocks;
  final bool isPast;
  final bool isDisabled;

  const Period({
    required this.schedules,
    required this.timeBlocks,
    this.isPast = false,
    this.isDisabled = false,
  });
}
