import 'package:flutter/material.dart';

class Dateandtime extends StatelessWidget {
  const Dateandtime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowDateTimePicker(),
    );
  }
}

class ShowDateTimePicker extends StatefulWidget {
  const ShowDateTimePicker({Key? key}) : super(key: key);
  @override
  _ShowDateTimePicker createState() => _ShowDateTimePicker();
}

class _ShowDateTimePicker extends State<ShowDateTimePicker> {
  final TextEditingController _textDate = TextEditingController();
  final TextEditingController _textTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: const Text('Date and time picker'),
        ),
        body: Container(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textDate,
                decoration: const InputDecoration(
                  hintText: "Select Date",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    if (date != null) {
                      _textDate.text = "${date.day}-${date.month}-${date.year}";
                    }
                  });
                },
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // we will set here time now
              TextField(
                controller: _textTime,
                decoration: const InputDecoration(
                  hintText: "Select Time",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    if (time != null) {
                      _textTime.text = time.format(context);
                    }
                  });
                },
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
        //End timer set here
        );
  }
}
