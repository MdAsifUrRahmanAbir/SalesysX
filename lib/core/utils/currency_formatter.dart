/// Formats amounts as Bangladeshi Taka using South-Asian (lakh-style)
/// digit grouping — groups of 2 after the first group of 3 from the
/// right, e.g. ৳1,60,000 and ৳12,500, matching the convention already
/// used throughout the app's design.
class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(double amount) {
    final isWhole = amount == amount.roundToDouble();
    final fixed = (isWhole ? amount.toStringAsFixed(0) : amount.toStringAsFixed(2));
    final negative = fixed.startsWith('-');
    final unsigned = negative ? fixed.substring(1) : fixed;
    final parts = unsigned.split('.');
    final grouped = _groupSouthAsian(parts[0]);
    final decimals = parts.length > 1 ? '.${parts[1]}' : '';
    return '৳${negative ? '-' : ''}$grouped$decimals';
  }

  static String _groupSouthAsian(String digits) {
    if (digits.length <= 3) return digits;
    var rest = digits.substring(0, digits.length - 3);
    final groups = <String>[digits.substring(digits.length - 3)];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return groups.join(',');
  }
}
