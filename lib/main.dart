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
               <script src="https://www.paypal.com/sdk/js?client-id=AVKt4Ll68c5_R7cDuevqZrk1o0WjX7kGywsVLIwHdrVRtNS9qa0n5XtQDpD66DTvBB7I76qN0ZUulztt&currency=JPY"> // Replace YOUR_CLIENT_ID with your actual client ID
    </script>

  <script>
        paypal.Buttons({
            createOrder: function(data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: '5' // Charge 5 JPY
                        }
                    }]
                });
            },
            onApprove: function(data, actions) {
                return actions.order.capture().then(function(details) {
                    alert('Transaction completed by ' + details.payer.name.given_name);

                    var payerEmail = details.payer.email_address;

                    fetch('https://testapi.com/test?email=' + payerEmail)
                    .then(response => response.json())
                    .then(data => console.log(data))
                    .catch((error) => {
                      console.error('Error:', error);
                    });
                });
            }
        }).render('#paypal-button-container');
    </script><div id="paypal-button-container"></div>''',
          initialSourceType: SourceType.html,
          height: 500, //サイズは適当
          width: 500, //サイズは適当
          onWebViewCreated: (controller) => _webviewController = controller,
        ),
      ),
    );
  }
}
