import 'package:flutter/material.dart';
import 'package:my_time/screens/settings_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../models/timer_model.dart';
import '../utils/app_colors.dart';
import '../widgets/home_button.dart';

class TimerHomePage extends StatelessWidget {
  TimerHomePage({
    super.key,
  });

  final CountDownTimer timer = CountDownTimer()..initStorage();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem> menuItems = [];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Work Timer'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems;
            },
            onSelected: (value) {
              if (value == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      timer: timer,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: HomeTimerButton(
                        text: 'Work',
                        bgColor: AppColors.primaryColor,
                        onPressed: () {
                          timer.startWork();
                        },
                        textColor: AppColors.textColor,
                      ),
                    ),
                    Expanded(
                      child: HomeTimerButton(
                        text: 'Short Break',
                        bgColor: AppColors.accentColor,
                        onPressed: () {
                          timer.startBreak(true);
                        },
                        textColor: AppColors.textColor,
                      ),
                    ),
                    Expanded(
                      child: HomeTimerButton(
                        text: 'Long Break',
                        bgColor: AppColors.lightPrimaryColor,
                        onPressed: () {
                          timer.startBreak(false);
                        },
                        textColor: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                StreamBuilder<TimerModel>(
                  initialData: TimerModel(time: '00:00', percent: 1),
                  stream: timer.stream(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    TimerModel timerModel = snapshot.hasData
                        ? snapshot.data
                        : TimerModel(time: '00:00', percent: 1);
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 4,
                        lineWidth: 10,
                        percent: timerModel.percent,
                        center: Text(timerModel.time),
                        progressColor: AppColors.lightPrimaryColor,
                        backgroundColor: AppColors.accentColor,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: HomeTimerButton(
                        text: 'Stop',
                        bgColor: AppColors.primaryText,
                        onPressed: () {
                          timer.stopTimer();
                        },
                        textColor: AppColors.textColor,
                      ),
                    ),
                    Expanded(
                      child: HomeTimerButton(
                        text: 'Restart',
                        bgColor: AppColors.primaryColor,
                        onPressed: () {
                          timer.startTimer();
                        },
                        textColor: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
