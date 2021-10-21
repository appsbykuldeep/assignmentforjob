import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'list_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication auth = LocalAuthentication();
  var authsupport = false.obs;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      auth.isDeviceSupported().then(
        (isSupported) {
          authsupport.value = isSupported;
          authenticate();
        },
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  authenticate() async {
    final isAvailable = await auth.canCheckBiometrics;
    if (!isAvailable) return false;

    try {
      bool _result = await auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
      );

      if (_result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ListScreen()),
            (route) => false);
      }
    } catch (e) {
      debugPrint("authenticate : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              height: Get.height,
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Column(
                children: [
                  const Expanded(
                    child: FlutterLogo(
                      size: 250,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (authsupport.value) {
                          authenticate();
                        }
                      },
                      child: "Authenticate".text.bold.xl.makeCentered()),
                ],
              )),
        ),
      ),
    );
  }
}
