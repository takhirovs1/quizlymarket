/* eslint-disable no-console */
(function telegramWebAppSimulator(global) {
  'use strict';

  const telegram = global.Telegram;
  const hasRealTelegramUser = Boolean(telegram?.WebApp?.initDataUnsafe?.user);
  if (hasRealTelegramUser) return;

  const params = new URLSearchParams(global.location.search);
  const hostIsLocal = ['localhost', '127.0.0.1', '[::1]'].includes(global.location.hostname);

  const storage = (() => {
    try {
      return global.localStorage;
    } catch (_) {
      return null;
    }
  })();

  const readStorage = (key) => {
    if (!storage) return null;
    try {
      return storage.getItem(key);
    } catch (_) {
      return null;
    }
  };

  const writeStorage = (key, value) => {
    if (!storage) return;
    try {
      storage.setItem(key, value);
    } catch (_) {}
  };

  const removeStorage = (key) => {
    if (!storage) return;
    try {
      storage.removeItem(key);
    } catch (_) {}
  };

  const flagFromQuery = params.get('tgDebug');
  const storedFlag = readStorage('tgDebug');

  if (flagFromQuery === '0' || flagFromQuery?.toLowerCase() === 'false') {
    removeStorage('tgDebug');
    removeStorage('tgDebugUser');
    return;
  }

  if (flagFromQuery === '1' || flagFromQuery?.toLowerCase() === 'true') {
    writeStorage('tgDebug', 'true');
  }

  const shouldSimulate =
    hostIsLocal ||
    flagFromQuery === '1' ||
    flagFromQuery?.toLowerCase() === 'true' ||
    storedFlag === '1' ||
    storedFlag?.toLowerCase() === 'true';

  if (!shouldSimulate) return;

  const tryJson = (value) => {
    if (!value) return null;
    try {
      return JSON.parse(value);
    } catch (_) {
      return null;
    }
  };

  const tryBase64Json = (value) => {
    if (!value) return null;
    try {
      return tryJson(global.atob(value));
    } catch (_) {
      return null;
    }
  };

  const parseUser = (raw) => tryJson(raw) ?? tryBase64Json(raw);

  const mockUser = parseUser(params.get("tgUser")) ??
    parseUser(readStorage("tgDebugUser")) ?? {
      id: 1251798314,
      first_name: "Debug",
      last_name: "User",
      username: "debug_user",
      language_code: "en",
      is_premium: true,
      allows_write_to_pm: true,
      photo_url: "https://placehold.co/96x96",
    };

  console.log('mockUser', mockUser);

  writeStorage('tgDebugUser', JSON.stringify(mockUser));

  const now = Math.floor(Date.now() / 1000);

  const buttonFactory = (name) => {
    const state = { text: name, isVisible: false, isActive: true };
    return {
      setText: (text) => {
        state.text = text;
        console.info(`[tg-sim] ${name}.setText(${text})`);
      },
      show: () => {
        state.isVisible = true;
        console.info(`[tg-sim] ${name}.show()`);
      },
      hide: () => {
        state.isVisible = false;
        console.info(`[tg-sim] ${name}.hide()`);
      },
      enable: () => {
        state.isActive = true;
        console.info(`[tg-sim] ${name}.enable()`);
      },
      disable: () => {
        state.isActive = false;
        console.info(`[tg-sim] ${name}.disable()`);
      },
      onClick: (callback) => {
        state.onClick = callback;
        console.info(`[tg-sim] ${name}.onClick(callback)`);
      },
      offClick: () => {
        state.onClick = undefined;
        console.info(`[tg-sim] ${name}.offClick()`);
      },
    };
  };

  const simulator = {
    version: '7.9',
    platform: params.get('tgPlatform') ?? 'tdesktop',
    colorScheme: global.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light',
    themeParams: {},
    initData: 'debug=1',
    initDataUnsafe: {
      query_id: 'debug',
      user: mockUser,
      auth_date: now,
      hash: 'debug-hash',
      start_param: params.get('tgStartParam') ?? '',
    },
    isExpanded: true,
    isClosingConfirmationEnabled: false,
    isSupported: true,
    ready: () => console.info('[tg-sim] ready()'),
    expand: () => console.info('[tg-sim] expand()'),
    close: () => console.info('[tg-sim] close()'),
    disableVerticalSwipes: () => console.info('[tg-sim] disableVerticalSwipes()'),
    enableClosingConfirmation: () => console.info('[tg-sim] enableClosingConfirmation()'),
    disableClosingConfirmation: () => console.info('[tg-sim] disableClosingConfirmation()'),
    sendData: (data) => console.info('[tg-sim] sendData', data),
    onEvent: (event, handler) => console.info('[tg-sim] onEvent', event, handler),
    offEvent: (event, handler) => console.info('[tg-sim] offEvent', event, handler),
    isVersionAtLeast: () => true,
    MainButton: buttonFactory('MainButton'),
    BackButton: buttonFactory('BackButton'),
  };

  global.Telegram = telegram ?? {};
  global.Telegram.WebApp = { ...(telegram?.WebApp ?? {}), ...simulator };

  const fullName = [mockUser.first_name, mockUser.last_name].filter(Boolean).join(' ');
  console.info(
    '%cTelegram WebApp simulator enabled%c user=%s',
    'color:#30a4e6;font-weight:bold;',
    'color:inherit;font-weight:normal;',
    fullName || mockUser.username || mockUser.id,
  );
})(window);

