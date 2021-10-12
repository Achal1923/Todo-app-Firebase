import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{

  static final _notification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
          android: AndroidNotificationDetails(
                    'channel id',
                    'channel name',
                    'channel description',
                    importance: Importance.max,
                    ),
          iOS: IOSNotificationDetails(),
    );
}

  static Future taskCreatedNotification()async => _notification.show(
        0,
        'ToDo Created!',
        'A new Todo Task Created!',

        await _notificationDetails(),
      payload: 'Todo',
    );


  static Future taskCompletedonTimeNotification()async => _notification.show(
      2,
      'ToDo Completed!',
      'YaY! You Completed the task successfully, on time.',
      await _notificationDetails(),
      payload: 'Todo',
    );


  static Future taskCompletedNotification()async => _notification.show(
      3,
      'ToDo Completed!',
      'YaY! You Completed the task successfully.',
      await _notificationDetails(),
      payload: 'Todo',
    );


  static Future taskDeletedNotification()async => _notification.show(
      4,
      'ToDo Deleted!',
      'A Task was deleted.',
      await _notificationDetails(),
      payload: 'Todo',
    );


  static Future taskUpdateNotification()async => _notification.show(
      1,
      'ToDo Updated!',
      'A Task info was Updated.',
      await _notificationDetails(),
      payload: 'Todo',
    );

}