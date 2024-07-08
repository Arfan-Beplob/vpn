import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: VPNConnectionScreen() ,
    );
  }
}
class VPNConnectionScreen extends StatefulWidget {
  @override
  _VPNConnectionScreenState createState() => _VPNConnectionScreenState();
}

class _VPNConnectionScreenState extends State<VPNConnectionScreen> {
 late final OpenVPN vpnClient;

  @override
  void initState() {
    super.initState();
    vpnClient = OpenVPN(
      onConnectionEstablished: () {
        // VPN connection is established
      },
      onConnectionException: (error) {
        // Handle connection error
      },
      onDisconnect: () {
        // VPN disconnected
      },
    );
  }

  Future<void> connectToVPN() async {
    try {
      final config = OpenVPNConfig(
        remoteAddress: 'your_vpn_server_address',
        username: 'your_vpn_username',
        password: 'your_vpn_password',
        // Add other VPN configuration settings here
      );

      await vpnClient.connectTo(config);
    } catch (e) {
      // Handle connection error
    }
  }

  Future<void> disconnectFromVPN() async {
    await vpnClient.disconnect();
  }

  @override
  void dispose() {
    vpnClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Connection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: connectToVPN,
              child: Text('Connect to VPN'),
            ),
            ElevatedButton(
              onPressed: disconnectFromVPN,
              child: Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}
