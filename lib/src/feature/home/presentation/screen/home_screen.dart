import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../state/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeState {
  @override
  Widget build(BuildContext context) {
    final user = telegramUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Telegram Profile')),
      body: user == null ? const _MissingUserState() : _UserProfile(user: user),
    );
  }
}

class _MissingUserState extends StatelessWidget {
  const _MissingUserState();

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Telegram foydalanuvchi maʼlumotlari topilmadi.\n'
            'Mini-appni Telegram ichida ishga tushiring yoki bot orqali kirishni tekshiring.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
}

class _UserProfile extends StatelessWidget {
  const _UserProfile({required this.user});

  final WebAppUser user;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProfileHeader(user: user),
          const SizedBox(height: 24),
          _InfoTile(
            icon: Icons.badge_outlined,
            title: 'Full name',
            value: _fullName(user),
          ),
          if (user.username != null)
            _InfoTile(
              icon: Icons.alternate_email,
              title: 'Username',
              value: '@${user.username}',
            ),
          _InfoTile(icon: Icons.language_outlined, title: 'Language', value: user.languageCode ?? 'unknown'),
          _InfoTile(
            icon: Icons.verified_user_outlined,
            title: 'Premium',
            value: user.isPremium == true ? 'Enabled' : 'Disabled',
          ),
          _InfoTile(
            icon: Icons.tag_outlined,
            title: 'User ID',
            value: user.id.toString(),
          ), 
          // _InfoTile(
          //   icon: Icons.tag_outlined,
          //   title: 'User ID',
          //   value: user..toString(),
          // ), 
        ],
      ),
    );
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final WebAppUser user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoUrl = user.photoUrl;
    final rasterPhotoUrl = photoUrl != null && !photoUrl.toLowerCase().endsWith('.svg') ? photoUrl : null;
    final initials = _initials(user);

    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: rasterPhotoUrl != null
              ? ClipOval(
                  child: Image.network(
                    rasterPhotoUrl,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Text(initials, style: theme.textTheme.headlineSmall),
                  ),
                )
              : Text(
                  initials.isEmpty ? user.firstName[0] : initials,
                  style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                ),
        ),
        const SizedBox(height: 12),
        Text(
          _fullName(user),
          style: theme.textTheme.headlineSmall,
        ),
        if (user.username != null)
          Text(
            '@${user.username}',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
          title: Text(title),
          subtitle: Text(value),
        ),
      );
}

String _fullName(WebAppUser user) {
  final last = user.lastName?.trim();
  if (last == null || last.isEmpty) return user.firstName;

  return '${user.firstName} $last';
}

String _initials(WebAppUser user) {
  final initials = <String>[];
  if (user.firstName.isNotEmpty) initials.add(user.firstName[0].toUpperCase());
  final last = user.lastName?.trim();
  if (last != null && last.isNotEmpty) initials.add(last[0].toUpperCase());

  return initials.join();
}
