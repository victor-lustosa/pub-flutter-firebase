import 'dart:math';

class IdUtil {
  static String generateRandomString() {
    var id = DateTime.now().microsecondsSinceEpoch.toString();
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(
          10,
          (index) => chars[r.nextInt(chars.length)],
        ).join() + id;
  }
}
