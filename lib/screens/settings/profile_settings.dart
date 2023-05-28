import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/screens/login.dart';
import 'package:genibook/services/backgroundtasks.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _enabled = false;
  bool _bioAuthEnabled = false;
  int latency = -1;

  @override
  void initState() {
    ConfigCache.readBgFetchVal().then((bool value) {
      if (!mounted) return;
      setState(() {
        _enabled = value;
      });
    });
    ConfigCache.readBioAuth().then((bool value) {
      if (!mounted) return;
      setState(() {
        _bioAuthEnabled = value;
      });
    });
    super.initState();
  }

  void _onClickEnable(bool enabled) async {
    HapticFeedback.mediumImpact();

    await ConfigCache.storeBgFetchVal(enabled);
    setBackgroundFetch(enabled);
    setState(() {
      _enabled = enabled;
    });

    if (!mounted) return;
  }

  void _onBioToggle(bool enabled) async {
    HapticFeedback.mediumImpact();
    await ConfigCache.storeBioAuth(enabled);
    setState(() {
      _bioAuthEnabled = enabled;
    });

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Profile Settings",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Logout: ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              IconButton(
                  onPressed: () async {
                    await StoreObjects.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .push(SlideToRightPageRoute(child: const LoginPage()));
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Test latency: ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      "$latency ms",
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          HapticFeedback.lightImpact();
                          int lat = await ApiHandler.getLatencyThroughLogin();
                          setState(() {
                            latency = lat;
                          });
                        },
                        icon: const Icon(Icons.refresh)),
                  ],
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Clear Notifications: ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              IconButton(
                  onPressed: () async {
                    HapticFeedback.heavyImpact();
                    if (await AwesomeNotifications().getGlobalBadgeCounter() >
                        0) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Notifications Cleared!"),
                      ));
                      AwesomeNotifications().setGlobalBadgeCounter(0);
                    }
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Background Refresh: ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Switch(
                value: _enabled,
                onChanged: _onClickEnable,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Use Face-ID to login: ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Switch(
                value: _bioAuthEnabled,
                onChanged: _onBioToggle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
