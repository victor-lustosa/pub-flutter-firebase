import 'dart:math';

class IdUtil {
static String generateRandomString() {
  var id = DateTime.now().microsecondsSinceEpoch.toString();
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join() + id;
}
}


