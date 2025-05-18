import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/app_header.dart';
import '../../auth/services/auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final AuthService _authService;
  late final AnimationController _animationController;
  late final List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _initAuthService();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _cardAnimations = List.generate(
      8,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.05,
            0.5 + index * 0.05,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initAuthService() async {
    final prefs = await SharedPreferences.getInstance();
    _authService = AuthService(prefs);
    
    // Check if user is logged in
    if (!_authService.isLoggedIn() && mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'RevoTime',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          for (int i = 0; i < 8; i++)
                            AnimatedBuilder(
                              animation: _cardAnimations[i],
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _cardAnimations[i].value,
                                  child: Transform.translate(
                                    offset: Offset(
                                      0,
                                      20 * (1 - _cardAnimations[i].value),
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              child: _buildReminderCard(
                                context,
                                title: _getCardTitle(i),
                                subtitle: _getCardSubtitle(i),
                                icon: _getCardIcon(i),
                                color: _getCardColor(i),
                                onTap: () {
                                  // TODO: Navigate to respective page
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildUpcomingRemindersCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingRemindersCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.notifications_active,
                  color: Color(0xFF2C3E50),
                ),
                const SizedBox(width: 8),
                Text(
                  'Yaklaşan Hatırlatıcılar',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF2C3E50),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Lottie.asset(
                    'assets/animations/login-animation.json',
                    height: 100,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReminderItem(
                        context,
                        date: '23 Mart',
                        title: 'Kira Ödemesi',
                        time: '14:00',
                      ),
                      const SizedBox(height: 12),
                      _buildReminderItem(
                        context,
                        date: '24 Mart',
                        title: 'Doktor Randevusu',
                        time: '10:30',
                      ),
                      const SizedBox(height: 12),
                      _buildReminderItem(
                        context,
                        date: '25 Mart',
                        title: 'Toplantı',
                        time: '15:00',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderItem(
    BuildContext context, {
    required String date,
    required String title,
    required String time,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            date,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2C3E50),
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          time,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF2C3E50),
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  String _getCardTitle(int index) {
    switch (index) {
      case 0:
        return 'Ödemeler';
      case 1:
        return 'Etkinlikler';
      case 2:
        return 'İş';
      case 3:
        return 'Kişisel';
      case 4:
        return 'Sağlık';
      case 5:
        return 'Eğitim';
      case 6:
        return 'Alışveriş';
      case 7:
        return 'Sosyal';
      default:
        return '';
    }
  }

  String _getCardSubtitle(int index) {
    switch (index) {
      case 0:
        return '5 hatırlatıcı';
      case 1:
        return '3 hatırlatıcı';
      case 2:
        return '7 hatırlatıcı';
      case 3:
        return '4 hatırlatıcı';
      case 4:
        return '2 hatırlatıcı';
      case 5:
        return '6 hatırlatıcı';
      case 6:
        return '3 hatırlatıcı';
      case 7:
        return '5 hatırlatıcı';
      default:
        return '';
    }
  }

  IconData _getCardIcon(int index) {
    switch (index) {
      case 0:
        return Icons.payment;
      case 1:
        return Icons.event;
      case 2:
        return Icons.work;
      case 3:
        return Icons.person;
      case 4:
        return Icons.health_and_safety;
      case 5:
        return Icons.school;
      case 6:
        return Icons.shopping_cart;
      case 7:
        return Icons.people;
      default:
        return Icons.error;
    }
  }

  Color _getCardColor(int index) {
    final colors = [
      const Color(0xFF7FB1ED),
      const Color(0xFF9CC2F0),
      const Color(0xFFB5D4F5),
      const Color(0xFF7FB1ED),
      const Color(0xFF9CC2F0),
      const Color(0xFFB5D4F5),
      const Color(0xFF7FB1ED),
      const Color(0xFF9CC2F0),
    ];
    return colors[index % colors.length];
  }

  Widget _buildReminderCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: const Color(0xFF2C3E50),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF2C3E50),
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF2C3E50).withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 