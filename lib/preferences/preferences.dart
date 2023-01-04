import 'package:get_storage/get_storage.dart';

class Preferences {
  final storage = GetStorage();

  void setNotificationId(String notificationId) =>
      storage.write("notificationId", notificationId);
  getnotificationId() => storage.read("notificationId");
}
