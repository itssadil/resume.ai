String formatDate(DateTime date) {
  // Extract year, month, and day as strings
  final year = date.year.toString();
  final month =
      date.month.toString().padLeft(2, '0'); // Pad month with leading zero
  final day = date.day.toString().padLeft(2, '0'); // Pad day with leading zero

  return '$day.$month.$year'; // Combine formatted components
}
