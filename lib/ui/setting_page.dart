import 'package:bfaf_submission2/provider/preference_provider.dart';
import 'package:bfaf_submission2/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, _) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Scheduling Restaurant'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestoActive,
                      onChanged: (value) async {
                        scheduled.scheduledResto(value);
                        provider.enableDailyResto(value);
                      },
                    );
                  },
                ),
              )
            ]
          );
        },
      )
    );
  }
}