import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Scale animation
    _animation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true); // Loop the animation

    // Navigate to the main screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const CurrencyConverterMaterialPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/app_icon.png', // Replace with your app icon path
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Currency Converter",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  late double result = 0;
  final TextEditingController textEditingController = TextEditingController();

// Map for currency conversion rates
  final Map<String, double> currencyRates = {
    'USD': 0.012, // 1 INR = 0.012 USD
    'GBP': 0.0096, // 1 INR = 0.0096 GBP
    'EUR': 0.011, // 1 INR = 0.011 EUR
    'JPY': 1.74, // 1 INR = 1.74 JPY
    'AUD': 0.018, // 1 INR = 0.018 AUD
    'CAD': 0.016, // 1 INR = 0.016 CAD
    'CNY': 0.087, // 1 INR = 0.087 CNY
    'SGD': 0.016, // 1 INR = 0.016 SGD
    'AED': 0.044, // 1 INR = 0.044 AED
    'SAR': 0.045, // 1 INR = 0.045 SAR
    'CHF': 0.011, // 1 INR = 0.011 CHF
    'NZD': 0.019, // 1 INR = 0.019 NZD
    'ZAR': 0.22, // 1 INR = 0.22 ZAR
    'SEK': 0.13, // 1 INR = 0.13 SEK
    'HKD': 0.094, // 1 INR = 0.094 HKD
    'THB': 0.43, // 1 INR = 0.43 THB
    'KRW': 15.9, // 1 INR = 15.9 KRW
    'MYR': 0.056, // 1 INR = 0.056 MYR
  };
  String selectedCurrency = 'USD';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black45,
          width: 2,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignInside),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      gapPadding: 4.0,
    );
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 0 for the initial no calculation
            // Text(
            //   "INR ${result != 0 ? result.toStringAsFixed(1) : result.toStringAsFixed(0)}",
            //   style: const TextStyle(
            //     fontSize: 45,
            //     color: Color.fromARGB(221, 255, 255, 255),
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

            Text(
              "$selectedCurrency ${result != 0 ? result.toStringAsFixed(1) : result.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 45,
                color: Color.fromARGB(221, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            // next widget
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter amount in INR',
                  labelStyle: TextStyle(color: Colors.black54),
                  hintText: "Please enter amount",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  prefixIcon:
                      Icon(Icons.currency_rupee_sharp), //monetization_on
                  prefixIconColor: Colors.white60,
                  filled: true,
                  fillColor: Colors.white54,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: true,
                ),
              ),
            ),

// Dropdown to select target currency
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: selectedCurrency,
                items: currencyRates.keys
                    .map(
                      (currency) => DropdownMenuItem<String>(
                        value: currency,
                        child: Text(
                          currency,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white54,
                  labelText: 'Select Target Currency',
                ),
              ),
            ),

            // Adding Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // onPressed: () {
                //   setState(() {
                //     //to rebuld the things
                //     result = double.parse(textEditingController.text) * 81;
                //   });
                // },

                onPressed: () {
                  setState(() {
                    // Perform conversion
                    double inrAmount =
                        double.tryParse(textEditingController.text) ?? 0;
                    double conversionRate = currencyRates[selectedCurrency]!;
                    result = inrAmount * conversionRate;
                  });
                },
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(15),
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.blue), // Background color
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 50),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(),
                  ),
                ),
                child: const Text(
                  "Convert",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
