// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/babies.dart';
import 'models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'Billy', breed: 'Bulldog', age: 3),
        ),
        FutureProvider<int>(
            initialData: 0,
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              final babies = Babies(age: dogAge);
              return babies.getBabies();
            })
      ],
      child: MaterialApp(
        title: 'Provider 06',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider 06"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '- name: ${context.select<Dog, String>((Dog dog) => dog.name)}',
              style: const TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('- breed: ${context.select<Dog, String>((Dog dog) => dog.breed)}',
            style: TextStyle(fontSize: 20.0)),
        SizedBox(
          height: 10.0,
        ),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${context.select<Dog, int>((Dog dog) => dog.age)}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '- number of babies: ${context.watch<int>()}',
          style: TextStyle(fontSize: 20.0),
        ),
        ElevatedButton(
          onPressed: () => context.read<Dog>().grow(),
          child: Text(
            'Grow',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
