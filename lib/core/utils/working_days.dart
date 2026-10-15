/// Counts working days (Bangladesh's standard weekly holiday is Friday
/// only) — shared by anything computing a target run-rate: target
/// performance, team dashboards, reports, and the demo seeder.
class WorkingDays {
  WorkingDays._();

  /// Inclusive day count between [start] and [end], excluding Fridays.
  static int count(DateTime start, DateTime end) {
    var count = 0;
    for (var d = DateTime(start.year, start.month, start.day);
        !d.isAfter(end);
        d = d.add(const Duration(days: 1))) {
      if (d.weekday != DateTime.friday) count++;
    }
    return count;
  }
}
