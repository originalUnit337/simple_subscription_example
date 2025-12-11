import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_subscription_example/navigation/app_route.dart';
import 'package:simple_subscription_example/services/local_storage.dart';

class OnboardingPage extends StatefulWidget {
  final LocalStorage storage;
  const OnboardingPage({required this.storage, super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_SlideData> slides = [
    _SlideData(
      title: 'Добро пожаловать',
      desc: 'Удобный payroll для вашей компании',
      color: Colors.blueAccent,
    ),
    _SlideData(
      title: 'Автоматизация',
      desc: 'Управляйте выплатами легко',
      color: Colors.deepPurple,
    ),
    _SlideData(
      title: 'Безопасно',
      desc: 'Конфиденциальность и контроль',
      color: Colors.teal,
    ),
  ];

  void _onContinue() {
    // перейти на экран подписки
    context.go(AppRoute.subscription.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  final s = slides[i];
                  return Container(
                    color: s.color,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              s.title,
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              s.desc,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(slides.length, (i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _index == i ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _index == i ? Colors.black : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _index == slides.length - 1
                        ? ElevatedButton(
                            onPressed: _onContinue,
                            child: const Text('Продолжить'),
                          )
                        : TextButton(
                            onPressed: () {
                              final next = (_index + 1).clamp(
                                0,
                                slides.length - 1,
                              );
                              _controller.animateToPage(
                                next,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text('Далее'),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String desc;
  final Color color;
  _SlideData({required this.title, required this.desc, required this.color});
}
