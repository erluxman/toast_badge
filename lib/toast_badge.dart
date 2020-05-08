library toast_badge;

import 'dart:async';

import 'package:flutter/material.dart';

export 'toast_badge.dart';

class _NotificationWidget extends StatelessWidget {
  const _NotificationWidget(this.notification);

  final ToastMessage notification;

  @override
  Widget build(BuildContext context) {
    if (notification == null) return Container();
    return Container(
      decoration: BoxDecoration(
        color: getNotificationColor(notification.toastMode),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 0,
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Text(
                notification.message,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ToastBadge.show(null);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Color getNotificationColor(ToastMode mode) {
    if (mode == ToastMode.INFO) return Colors.green;
    if (mode == ToastMode.ERROR)
      return Colors.red;
    else
      return Colors.blue;
  }
}

class ToastMessage {
  ToastMessage({this.message, this.toastMode});

  String message;
  ToastMode toastMode;
}

enum ToastMode { ERROR, INFO, DEBUG }

// ignore: must_be_immutable
class ToastBadge extends StatelessWidget with ChangeNotifier {
  ToastBadge({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ToastMessage>(
        initialData: null,
        stream: toastMessages(),
        builder: (context, snapshot) {
          return Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: <Widget>[
              child ?? Container(),
              _NotificationWidget(snapshot.data),
            ],
          );
        });
  }

  static StreamController<ToastMessage> _notificationCarrier =
      StreamController.broadcast();

  static Timer toastTimer;

  static Stream<ToastMessage> toastMessages() => _notificationCarrier.stream;

  static show(String message,
      {ToastMode mode = ToastMode.DEBUG, Duration duration}) async {
    _notificationCarrier.add((message == null)
        ? null
        : ToastMessage(message: message, toastMode: mode));
    toastTimer?.cancel();
    toastTimer = Timer(duration ?? Duration(seconds: 4), () {
      _notificationCarrier.add(null);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _notificationCarrier.close();
  }
}

extension ToastExtension on Widget {
  Widget enableBadge({bool enable = true}) {
    if (!enable) return this;
    return ToastBadge(child: this);
  }
}
