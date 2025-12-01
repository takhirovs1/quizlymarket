# quizlymarket

A Flutter mini app that surfaces Telegram Web App data.

## Getting Started

```bash
flutter pub get
flutter run -d chrome --web-port 4200
```

> The UI entry point lives in `lib/src/feature/home/presentation/screen/home_screen.dart`.

## Telegram WebApp debugging

Local browsers do not ship Telegram’s native container, so the `telegram_web_app` package normally reports  
`isSupported = false`. To make debugging easier we ship a lightweight simulator under
`web/telegram_web_app_simulator.js`. Whenever the app is opened from `localhost` (or when you force it with a
query flag) the script injects a mock `window.Telegram.WebApp` object so Flutter can read fake user data.

1. Start the web app: `flutter run -d chrome --web-port 4200 --web-renderer html`
2. Open `http://localhost:4200/?tgDebug=1` – this flips the simulator on.
3. (Optional) Override the mock user:
   ```js
   localStorage.setItem(
     'tgDebugUser',
     JSON.stringify({
       id: 123456789,
       first_name: 'QA',
       last_name: 'Engineer',
       username: 'qa_eng',
       language_code: 'en',
       is_premium: false,
     }),
   );
   location.reload();
   ```
4. You can also share a one-off payload through the URL:
   - Raw JSON (URL-encode it): `?tgDebug=1&tgUser=%7B%22id%22%3A%221%22...%7D`
   - Base64 JSON: `?tgDebug=1&tgUser=eyJpZCI6MTIzfQ==`
5. Disable the simulator any time via `?tgDebug=0` or by clearing `localStorage`.

With the simulator enabled, the home screen shows the mock Telegram profile, allowing you to exercise all the UI
code without having to embed the build inside Telegram. In production (Telegram in-app browser) the script is a
no-op and the real `Telegram.WebApp` interface stays untouched.
