import 'package:flutter/material.dart';
import 'package:simple_subscription_example/navigation/app_route.dart';
import 'package:simple_subscription_example/services/local_storage.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPage extends StatefulWidget {
  final LocalStorage storage;
  const SubscriptionPage({required this.storage, super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

enum Plan { monthly, yearly }

class _SubscriptionPageState extends State<SubscriptionPage> {
  Plan _selected = Plan.monthly;
  bool _loading = false;

  String _priceText(Plan p) {
    return p == Plan.monthly
        ? '499 ₽ / мес'
        : '4999 ₽ / год (≈ 2 мес бесплатно)';
  }

  Future<void> _purchase() async {
    setState(() => _loading = true);
    // имитация покупки
    await Future.delayed(const Duration(seconds: 3));
    await widget.storage.setSubscribed(true);
    setState(() => _loading = false);
    // перейти на главный экран
    if (mounted) context.go(AppRoute.home.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите подписку')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Месячная'),
              subtitle: Text(_priceText(Plan.monthly)),
              leading: RadioGroup(
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
                child: Radio<Plan>(value: Plan.monthly),
              ),
            ),
            ListTile(
              title: const Text('Годовая'),
              subtitle: Text(_priceText(Plan.yearly)),
              leading: RadioGroup(
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v!),
                child: Radio<Plan>(value: Plan.yearly),
              ),
            ),
            const SizedBox(height: 24),
            _loading
                ? Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('Обработка покупки...'),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.go(AppRoute.home.path);
                        },
                        child: const Text('Skip'),
                      ),
                      ElevatedButton(
                        onPressed: _purchase,
                        child: const Text('Продолжить и оплатить'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
