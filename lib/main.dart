import 'package:flutter/material.dart';
import 'package:provider_value/controller.dart';
import 'package:provider_value/injection.dart';
import 'package:provider/provider.dart';
import 'package:provider_value/product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Controller>(
      create: (context) => getIt<Controller>()..loadProducts(),
      child: const MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Value Example')),
      body: Consumer<Controller>(
        builder: (context, controller, child) {
          return controller.value.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failed: () => const Center(child: Text('Failed to load products')),
            loaded: (products) => ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(product: product),
                    ),
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            const SizedBox(height: 16),
            Text('Price: \$${product.price}'),
          ],
        ),
      ),
    );
  }
}
