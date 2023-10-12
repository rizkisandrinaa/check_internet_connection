import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late bool isConnected;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isConnected = true;
    _initConnectionStatus().then((_) {
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen((result) {
            setState(() {
              isConnected = result != ConnectivityResult.none;
            });
          });
    });
  }
  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
  Future<void> _initConnectionStatus() async {
    final result = await _connectivity.checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Internet Connection'),
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: Center(
        child: Image.asset(
          isConnected ? 'assets/connected.png' : 'assets/disconnected.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}