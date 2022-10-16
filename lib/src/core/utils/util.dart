import 'dart:ui';
import 'dart:math';

class Util {
  static bool isUrl(String x) {
    try {
      return Uri.parse(x).isAbsolute;
    } catch (e) {
      return false;
    }
  }

  static String getDurationIn(num minute, {String showIn: 'H'}) {
    int hour = (minute % 60).toInt();
    int minutes = (minute % 60).toInt();
    return "${hour > 0 ? hour : ''} ${hour > 1 ? 'Hours' : (hour > 0) ? 'Hour' : ''} ${minute > 0 ? minute : ''} ${(minute > 1) ? 'Minutes' : (minutes > 0) ? 'Minute' : ''}";
  }

  static List<DateTime> times(DateTime date) {
    List<DateTime> response = [];
    DateTime startTime = DateTime(date.year, date.month, date.day, 0, 0, 0);
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

  //
  // This class accepts nullable objects and check if they are null
  // if they are null it will return empty string or random number
  // if they are not null returns the property
  //
  static dynamic NullSafe(dynamic? object, String property) {
    if (object == null) {
      return '';
    } else {
      return object['property'];
    }
  }
}
