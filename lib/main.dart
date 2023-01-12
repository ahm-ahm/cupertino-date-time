import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _chosenDateTime;

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(ctx, {bool? isTimePickingMood}) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) =>
            Container(
              // height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: isTimePickingMood != null &&
                          isTimePickingMood == true
                          ? CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          // dateOrder: DatePickerDateOrder.dmy,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (val) {
                            setState(() {
                              final String time =
                                  val
                                      .toString()
                                      .split(' ')
                                      .last;
                              final int hr =
                              int.parse(time
                                  .split(':')
                                  .first);
                              final int min = int.parse(time.split(':')[1]);
                              if (hr >= 12 && min >= 0) {
                                if (hr > 12) {
                                  debugPrint(
                                      'after noon: hr:${hr - 12} min:$min PM');
                                  _chosenDateTime = '${hr - 12}:$min PM';
                                  // _chosenDateTime = (hr - 12).toString() +
                                  //     ':' +
                                  //     min.toString() +
                                  //     ' PM';
                                } else {
                                  _chosenDateTime = '$hr:$min PM';

                                  // _chosenDateTime = hr.toString() +
                                  //     ':' +
                                  //     min.toString() +
                                  //     ' PM';
                                }
                              } else {
                                _chosenDateTime = '$hr:$min AM';

                                // _chosenDateTime = hr.toString() +
                                //     ':' +
                                //     min.toString() +
                                //     ' AM';
                              }
                            });
                          })
                          : CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          dateOrder: DatePickerDateOrder.dmy,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (val) {
                            String formattedDate =
                            DateFormat('EEEd,MMM yy').format(val);
                            final String dth =
                                formattedDate
                                    .split(',')
                                    .first;
                            _chosenDateTime = dth +
                                'th, ' +
                                formattedDate
                                    .split(',')
                                    .last;
                            setState(() {});
                          }),
                    ),

                    // Close the modal
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Time and Date'),
        // This button triggers the _showDatePicker function
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              padding: EdgeInsetsDirectional.zero,
              child: const Text('Time'),
              onPressed: () =>
                  _showDatePicker(context, isTimePickingMood: true),
            ),
            const Text('Date And Time',
                style: TextStyle(fontWeight: FontWeight.bold)),
            CupertinoButton(
              padding: EdgeInsetsDirectional.zero,
              child: const Text('Date'),
              onPressed: () => _showDatePicker(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Text(_chosenDateTime != null
              ? _chosenDateTime.toString()
              : 'No date time picked!'),
        ),
      ),
    );
  }
}
