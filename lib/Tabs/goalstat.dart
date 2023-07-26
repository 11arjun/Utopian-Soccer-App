// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

Widget goalStat(int expandedTime, int homeGoal, int awayGoal) {
  var home = homeGoal;
  var away = awayGoal;
  var elapsed = expandedTime;
  if (home == null) home = 0;
  if (away == null) home = 0;
  if (elapsed == null) elapsed = 0;
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${elapsed}'",
          style: const TextStyle(
            fontSize: 30.0,
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${home}  - ${away}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 36.0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
