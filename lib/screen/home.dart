import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../providers/insta_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  // route name
  static const String routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // form key
  final _formKey = GlobalKey<FormState>();

  bool dataLoaded = false;

  String? username;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final instaUserProvider = Provider.of<InstaUsers>(context, listen: false);
      instaUserProvider.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final instaUserProvider = Provider.of<InstaUsers>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram Data',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 30,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Enter your Instagram username:'),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onChanged: (value) {
                  // instaUserProvider.username = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    dataLoaded = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            if (dataLoaded)
              const Text('Data Loaded')
            else
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text('Data Not Loaded',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
