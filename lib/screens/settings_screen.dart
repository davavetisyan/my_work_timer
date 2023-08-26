import 'package:flutter/material.dart';
import 'package:my_time/models/timer_model.dart';
import 'package:my_time/utils/app_constants.dart';

import '../widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.timer,
  });

  final CountDownTimer timer;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          SettingsItem(
            fieldName: 'Work',
            value: widget.timer.work,
            onMinusPressed: () {
              if (widget.timer.work > 0) {
                setState(() {
                  widget.timer.work -= 1;
                });
                widget.timer
                    .setSettings(AppConstants.WORKTIME, widget.timer.work);
              }
            },
            onPlusPressed: () {
              setState(() {
                widget.timer.work += 1;
                widget.timer
                    .setSettings(AppConstants.WORKTIME, widget.timer.work);
              });
            },
          ),
          SettingsItem(
            fieldName: 'Short',
            value: widget.timer.shortBreak,
            onMinusPressed: () {
              if (widget.timer.shortBreak > 0) {
                setState(() {
                  widget.timer.shortBreak -= 1;
                  widget.timer.setSettings(
                      AppConstants.SHORTBREAK, widget.timer.shortBreak);
                });
              }
            },
            onPlusPressed: () {
              setState(() {
                widget.timer.shortBreak += 1;
                widget.timer.setSettings(
                    AppConstants.SHORTBREAK, widget.timer.shortBreak);
              });
            },
          ),
          SettingsItem(
            fieldName: 'Long',
            value: widget.timer.longBreak,
            onMinusPressed: () {
              if (widget.timer.longBreak > 0) {
                setState(() {
                  widget.timer.longBreak -= 1;
                  widget.timer.setSettings(
                      AppConstants.LONGBREAK, widget.timer.longBreak);
                });
              }
            },
            onPlusPressed: () {
              setState(() {
                widget.timer.longBreak += 1;
                widget.timer.setSettings(
                    AppConstants.LONGBREAK, widget.timer.longBreak);
              });
            },
          ),
        ],
      ),
    );
  }
}
