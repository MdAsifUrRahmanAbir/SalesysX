class DateFormatter {
  DateFormatter._();

  static const _monthAbbr = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String format(DateTime date) => date.toIso8601String();

  /// e.g. "18 Jan 2024".
  static String shortDate(DateTime date) => '${date.day} ${_monthAbbr[date.month - 1]} ${date.year}';

  /// e.g. "10:15 AM".
  static String time(DateTime date) {
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $period';
  }

  /// e.g. "2m ago", "3h ago", "1d ago", falling back to [shortDate] once
  /// it's more than a week old.
  static String relative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return shortDate(date);
  }
}
