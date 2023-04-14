import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/presentation/pages/shop/components/shop_cart_page.dart';
import 'package:timer_app/presentation/pages/shop/shop_index_page.dart';
import 'package:timer_app/presentation/pages/timer/timer_page.dart';
import 'package:timer_app/presentation/providers/providers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:status_alert/status_alert.dart';
class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Widget> pages = const <Widget>[TimerPage(), ShopIndexPage()];
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });

    if (result != ConnectivityResult.wifi && result != ConnectivityResult.mobile) {
      StatusAlert.show(
        context,
        duration: const Duration(seconds: 2),
        title: 'Check your connection',
        configuration: const IconConfiguration(icon: Icons.wifi_off),
        maxWidth: 260,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkmodeProvider>(context);
    final countDownProvider = Provider.of<CountdownProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    List<Widget> actionButtons = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 0, minute: 0),
                    builder: (context, Widget? child) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: child!);
                    });
                countDownProvider.setCountdownDuration(Duration(
                    minutes: picked?.hour ?? 0, seconds: picked?.minute ?? 0));
              },
              child: const Icon(Icons.restart_alt_outlined)),
          const Padding(padding: EdgeInsets.only(top: 5)),
          FloatingActionButton(
            onPressed: () {
              countDownProvider.startStopTimer();
            },
            child: Icon(!countDownProvider.isRunning
                ? Icons.play_arrow_outlined
                : Icons.pause),
          ),
        ],
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ShopCartPage()));
        },
        child: Badge(
          label: Text('${cartProvider.products.length}'),
          child: const Icon(Icons.shopping_cart_rounded),
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: Icon(_getStatusIcon()),
        actions: [
          IconButton(
              onPressed: () {
                darkModeProvider.changeMode();
              },
              icon: const Icon(Icons.sunny))
        ],
      ),
      body: pages[selectedIndex],
      floatingActionButton: actionButtons[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 2,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: 'Timer'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'Shop')
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch(_connectionStatus){
      case ConnectivityResult.bluetooth:
        return Icons.bluetooth;
      case ConnectivityResult.wifi:
        return Icons.wifi;
      case ConnectivityResult.ethernet:
        return Icons.settings_ethernet;
      case ConnectivityResult.mobile:
        return Icons.lte_mobiledata;
      case ConnectivityResult.none:
        return Icons.airplanemode_active;
      case ConnectivityResult.vpn:
        return Icons.vpn_key;
      case ConnectivityResult.other:
        return Icons.settings_ethernet;
    }
  }
}
