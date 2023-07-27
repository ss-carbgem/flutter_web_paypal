import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewXController _webviewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: WebViewX(
          key: const ValueKey('webviewx'),
          initialContent: '''
            <div id="paypal-button-container-P-5X8102194C969025LMS7XYEQ"></div>
<script src="https://www.paypal.com/sdk/js?client-id=AfkCAsd5GPoXkDHNQ4ESHiizn9bqVz79jYo7pmP0plzsHimiMT90-hTrAu3iqsIfW73PUcRIk-pVN8sC&vault=true&intent=subscription" data-sdk-integration-source="button-factory"></script>
<script>
  paypal.Buttons({
      style: {
          shape: 'rect',
          color: 'gold',
          layout: 'vertical',
          label: 'subscribe'
      },
      createSubscription: function(data, actions) {
        return actions.subscription.create({
          /* Creates the subscription */
          plan_id: 'P-5X8102194C969025LMS7XYEQ'
        });
      },
      onApprove: function(data, actions) {
        alert(data.subscriptionID); // You can add optional success message for the subscriber here
      }
  }).render('#paypal-button-container-P-5X8102194C969025LMS7XYEQ'); // Renders the PayPal button
</script>''',
          initialSourceType: SourceType.html,
          height: 500, //サイズは適当
          width: 500, //サイズは適当
          onWebViewCreated: (controller) => _webviewController = controller,
        ),
      ),
    );
  }
}
