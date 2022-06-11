import 'package:CovidTracker/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
 
  static final String oneSignalAppId = "f77b95c9-b3c5-4174-bdc7-15ef7c959728";
  initPlatformState()async {
OneSignal.shared.setAppId(oneSignalAppId);
print(oneSignalAppId);
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
color: ybcolor,

    );
  }
}