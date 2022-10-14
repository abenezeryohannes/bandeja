import 'dart:ui';

class Util {
  static bool isUrl(String x) {
    try {
      return Uri.parse(x).isAbsolute;
    } catch (e) {
      return false;
    }
  }

  static List<DateTime> times(DateTime date) {
    List<DateTime> response = [];
    DateTime startTime = DateTime(date.year, date.month, date.day, 2, 0, 0);
    DateTime endTime = startTime.add(const Duration(hours: 24));
    for (DateTime index = startTime;
        index.isBefore(endTime);
        index = index.add(const Duration(hours: 1))) {
      response.add(index);
    }
    return response;
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
