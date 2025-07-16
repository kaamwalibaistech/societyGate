import 'package:intl/intl.dart';

String formatDate(String? dateStr) {
  if (dateStr == null) return '';
  final date = DateTime.tryParse(dateStr);
  return date != null ? DateFormat('dd MMM yyyy').format(date) : '';
}
