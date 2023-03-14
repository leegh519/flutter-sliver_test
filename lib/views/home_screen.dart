import 'package:flutter/material.dart';
import 'package:sliver_test/layout/default_layout.dart';
import 'package:sliver_test/views/sliver_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'home',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SliverListScreen(),
                  ),
                );
              },
              child: const Text('sliver list')),
        ],
      ),
    );
  }
}
