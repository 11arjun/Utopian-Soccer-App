import 'package:flutter/material.dart';
import 'package:utopiansoccer/Tabs/goalstat.dart';
import 'package:utopiansoccer/Tabs/matchtile.dart';
import 'package:utopiansoccer/Tabs/teamstat.dart';
import 'soccermodel.dart';

Widget pageBody(List<SoccerMatch> allmatches) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              teamstat("Local Team", allmatches[0].home.logoUrl,
                  allmatches[0].home.name),
              goalStat(allmatches[0].fixture.status.elapsedTime,
                  allmatches[0].goal.home, allmatches[0].goal.away),
              teamstat("Visitor Team", allmatches[0].away.logoUrl,
                  allmatches[0].away.name),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF4373D9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SingleChildScrollView(
                  child: Text(
                    "MATCHES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allmatches.length,
                    itemBuilder: (context, index) {
                      return matchTile(allmatches[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
