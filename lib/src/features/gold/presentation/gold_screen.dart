import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_gold_rate/src/features/gold/data/fake_gold_api.dart';
// Import your API service

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              StreamBuilder<double>(
                stream: getGoldPriceStream(), // Your fake Gold API stream
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    return Text(
                      NumberFormat.simpleCurrency(locale: 'de_DE').format(snapshot.data),
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Theme.of(context).colorScheme.primary),
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
