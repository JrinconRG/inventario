import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static final _date = DateFormat('dd/MM/yyyy');
  static final _dateTime = DateFormat('dd/MM/yyyy HH:mm');
  static final _time = DateFormat('HH:mm');

  static String formatDate(DateTime date) => _date.format(date);

  static String formatDateTime(DateTime date) => _dateTime.format(date);

  static String formatTime(DateTime date) => _time.format(date);

  static String formatRelative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()} año(s)';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} mes(es)';
    if (diff.inDays > 0) return 'hace ${diff.inDays} día(s)';
    if (diff.inHours > 0) return 'hace ${diff.inHours} hora(s)';
    if (diff.inMinutes > 0) return 'hace ${diff.inMinutes} min';
    return 'ahora';
  }

  static String diasParaVencer(DateTime fechaVencimiento) {
    final diff = fechaVencimiento.difference(DateTime.now());
    if (diff.isNegative) return 'Vencido hace ${diff.inDays.abs()} día(s)';
    if (diff.inDays == 0) return 'Vence hoy';
    return 'Vence en ${diff.inDays} día(s)';
  }

  static DateTime? parseDate(String dateStr) {
    try {
      return _date.parse(dateStr);
    } catch (_) {
      return null;
    }
  }
}
