import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'home_button.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem({
    super.key,
    required this.value,
    required this.fieldName,
    required this.onMinusPressed, 
    required this.onPlusPressed, 
  });
  int value;
  final String fieldName;
  final Function()? onMinusPressed;
  final Function()? onPlusPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              fieldName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: HomeTimerButton(
                  text: '-',
                  bgColor: AppColors.primaryText,
                  textColor: AppColors.textColor,
                  onPressed: onMinusPressed,  
                ),
              ),
              Expanded(
                child: HomeTimerButton(
                  text: '$value',
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.primaryText,
                  onPressed: null,
                ),
              ),
              Expanded(
                child: HomeTimerButton(
                  text: '+',
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.textColor,
                  onPressed: onPlusPressed,           
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
