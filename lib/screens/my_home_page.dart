import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:weather_counter/main.dart';

import '../helpers/weather_command.dart';
import '../managers/weather_manager.dart';
import '../models/weathers_model.dart';
import '../service_locator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var visibilityAdd = true;
  var visibilityRemove = true;
  bool darkTheme = false;

  void _incrementCounter() {
    print('Increment $_counter');
    _counter < 10
        ? darkTheme == true
            ? setState(() {
                visibilityAdd = true;
                _counter = _counter + 2;
                visibilityRemove = true;
              })
            : setState(() {
                visibilityAdd = true;
                _counter++;
                visibilityRemove = true;
              })
        : setState(() {
            visibilityAdd = false;
          });
  }

  void _decrementCounter() {
    print('Decrement $_counter');
    if (_counter > 0) {
      darkTheme == true
          ? setState(() {
              _counter = _counter - 2;
              visibilityAdd = true;
            })
          : setState(() {
              _counter--;
              visibilityAdd = true;
            });
    } else {
      setState(() {
        visibilityRemove = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<Weathers>(
                stream: sl<WeatherManagers>().weather$,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<Weathers> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('');
                    case ConnectionState.waiting:
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Press icon to get your location'),
                      );
                    case ConnectionState.active:
                      return _statusResult(context, snapshot.data);
                    case ConnectionState.done:
                      return Text('${snapshot.data} (closed)');
                  }
                },
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    onPressed: () => {
                      sl<WeatherManagers>().inRequest.add(RequestCommand.START)
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.cloud),
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton(
                    onPressed: () => {
                      darkTheme == false
                          ? {
                              MyApp.of(context).changeTheme(ThemeMode.dark),
                              setState(() {
                                darkTheme = true;
                              })
                            }
                          : {
                              MyApp.of(context).changeTheme(ThemeMode.light),
                              setState(() {
                                darkTheme = false;
                              })
                            }
                    },
                    // child: Text('Light'),

                    /*onPressed: () => {
                      setState(() {
                        print('Mode');
                        ThemeMode.dark;
                      })
                    },*/
                    tooltip: 'Decrement',
                    child: const Icon(Icons.color_lens),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                    visible: visibilityAdd,
                    child: FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  ),
                  SizedBox(height: 12),
                  Visibility(
                    visible: visibilityRemove,
                    child: FloatingActionButton(
                      onPressed: _decrementCounter,
                      tooltip: 'Decrement',
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _statusResult(BuildContext context, Weathers? data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'Weather in ${data!.name!} ${((data.main!.temp! - 32) * 5 / 9).toStringAsFixed(1)} °C [ ${(data.main!.temp)?.toStringAsFixed(1)} °F]',
        ),
      ),
    );
  }
}
