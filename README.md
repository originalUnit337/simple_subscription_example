# simple_subscription_example

## Описание
Лёгкое демо‑приложение на Flutter, реализующее максимально упрощенную Clean Architecture, с онбордингом, экраном выбора подписки и главным экраном с неким контентом. Маршрутизация — go_router; значение подписки хранится в SharedPreferences. Поведение: если пользователь купил подписку — при следующем запуске приложение открывает главный экран; пользователь может пропустить покупку и получить ограничённый доступ.

## Главные компоненты и поведение
AppRoute (enum) — хранит имя и путь каждого маршрута:
    onboarding: '/onboarding'
    subscription: '/subscription'
    home: '/'
- AppRouter — создаёт GoRouter и устанавливает initialLocation в зависимости от LocalStorage.isSubscribed.
- OnboardingPage — PageView с тремя слайдами (разные фоны). На последнем слайде кнопка "Продолжить" → SubscriptionPage.
- SubscriptionPage — выбор плана (месячная / годовая со скидкой). Кнопка "Продолжить и оплатить" эмулирует покупку (await Future.delayed 3s), затем сохраняет - - флаг isSubscribed=true и переходит на Home. Есть кнопка "Пропустить" — перейти на Home без покупки (isSubscribed остаётся false).
HomePage — Показывает разный контент в зависимости от storage.isSubscribed:
subscribed: полный доступ (сообщение).
not subscribed: ограниченный доступ + кнопка "Оформить подписку" (ведёт на SubscriptionPage).

## Возможные улучшение

Сделать конткрентое разграничение сфер ответственности классов.
Сделайть 3 слоя -> data, domain, presentation.
Чтобы ожидаемый dataflow был UI click -> BLoC reacts -> call usecase -> abstract domain repository called -> repostiory implementation on data reacts.
Такой подход даст гораздо больше пространства для дальнейшей масштабируемости проекта (к примеру не будет тяжело перейти с 1 бд на другую). Также легчче писать тесты.