/// Counts working days — shared by anything computing a target run-rate:
/// target performance, team dashboards and reports. The weekly holiday
/// comes from the company settings (Friday by default, Bangladesh's
/// standard), loaded at sign-in.
class WorkingDays {
  WorkingDays._();

  /// `DateTime.weekday` values that are not working days.
  static List<int> weekendDays = const [DateTime.friday];

  /// Inclusive day count between [start] and [end], excluding the weekly
  /// holiday.
  static int count(DateTime start, DateTime end, {List<int>? weekend}) {
    final off = weekend ?? weekendDays;
    var count = 0;
    for (var d = DateTime(start.year, start.month, start.day);
        !d.isAfter(end);
        d = d.add(const Duration(days: 1))) {
      if (!off.contains(d.weekday)) count++;
    }
    return count;
  }
}
