import 'package:flutter/material.dart';
import 'package:simple_subscription_example/services/local_storage.dart';

class HomePage extends StatefulWidget {
  final LocalStorage storage;
  const HomePage({super.key, required this.storage});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.storage.isSubscribed
            ? const Text('Премиум доступ')
            : const Text('Бесплатный доступ'),
      ),
      // body: Center(
      //   child: RotationTransition(
      //     turns: _ctrl,
      //     child: Container(
      //       width: 150,
      //       height: 150,
      //       decoration: BoxDecoration(
      //         gradient: const LinearGradient(
      //           colors: [Colors.orange, Colors.pink],
      //         ),
      //         borderRadius: BorderRadius.circular(20),
      //         boxShadow: [
      //           BoxShadow(
      //             color: Colors.black26,
      //             blurRadius: 8,
      //             offset: Offset(0, 4),
      //           ),
      //         ],
      //       ),
      //       child: const Center(
      //         child: Text(
      //           'Payroll',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 22,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            color: Colors.red,
            child: const Center(child: Text('1')),
          ),
          Container(
            color: Colors.blue,
            child: const Center(child: Text('2')),
          ),
          Container(
            color: Colors.green,
            child: const Center(child: Text('3')),
          ),
          Container(
            color: Colors.yellow,
            child: const Center(child: Text('4')),
          ),
        ],
      ),
    );
  }
}
