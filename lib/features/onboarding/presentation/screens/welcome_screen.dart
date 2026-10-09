import 'package:body_calendar/core/constants/app_constants.dart';
import 'package:body_calendar/core/theme/app_colors.dart';
import 'package:body_calendar/core/widgets/ios_widgets.dart';
import 'package:body_calendar/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _startAsGuest(BuildContext context, String method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyGuestStarted, true);
    await prefs.setString(AppConstants.keyGuestEntryMethod, method);
    if (!context.mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CalendarScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              IosIconBadge(
                icon: Icons.fitness_center_rounded,
                color: context.appPrimary,
                size: 88,
                iconSize: 44,
              ),
              const SizedBox(height: 24),
              Text(
                '펌핑데이',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '운동 기록을 시작해 보세요.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.appSecondaryText,
                ),
              ),
              const Spacer(flex: 3),
              _EntryButton(
                label: 'Google로 계속하기',
                icon: const Icon(Icons.g_mobiledata, size: 26),
                onTap: () => _startAsGuest(context, 'google'),
              ),
              const SizedBox(height: 12),
              _EntryButton(
                label: 'Apple로 계속하기',
                icon: const Icon(Icons.apple, size: 22),
                onTap: () => _startAsGuest(context, 'apple'),
              ),
              const SizedBox(height: 12),
              _EntryButton(
                label: '네이버로 계속하기',
                icon: const Text(
                  'N',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                onTap: () => _startAsGuest(context, 'naver'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: context.appSeparator)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '또는',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: context.appSecondaryText),
                    ),
                  ),
                  Expanded(child: Divider(color: context.appSeparator)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () => _startAsGuest(context, 'guest'),
                  child: const Text(
                    '로그인 없이 시작',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '어느 방법을 눌러도 계정 연동 없이 게스트로 시작돼요.\n'
                '기록은 이 기기에만 저장되고, 설정에서 클라우드 백업을 연결할 수 있어요.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.appSecondaryText,
                  height: 1.5,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryButton extends StatelessWidget {
  const _EntryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.appPrimaryText,
          side: BorderSide(color: context.appSeparator),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
