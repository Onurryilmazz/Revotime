import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/app_header.dart';

class ReminderGroupView extends StatefulWidget {
  final String title;
  final String groupId;

  const ReminderGroupView({
    super.key,
    required this.title,
    required this.groupId,
  });

  @override
  State<ReminderGroupView> createState() => _ReminderGroupViewState();
}

class _ReminderGroupViewState extends State<ReminderGroupView> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final TabController _tabController;
  bool _isUpcoming = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
 
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {
        _isUpcoming = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppHeader(
        title: widget.title,
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Lottie.asset(
                  'assets/animations/calendar.json',
                  controller: _animationController,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    _isUpcoming ? l10n.upcomingReminders : l10n.pastReminders,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.upcoming),
              Tab(text: l10n.past),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReminderList(isUpcoming: true),
                _buildReminderList(isUpcoming: false),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to add reminder
        },
        icon: const Icon(Icons.add),
        label: Text(l10n.addReminder),
      ),
    );
  }

  Widget _buildReminderList({required bool isUpcoming}) {
    // TODO: Replace with actual data
    final List<Map<String, dynamic>> reminders = [
      {
        'title': 'Kira Ödemesi',
        'date': '23 Mart 2024',
        'time': '14:00',
        'description': 'Aylık kira ödemesi',
        'isCompleted': false,
      },
      {
        'title': 'Doktor Randevusu',
        'date': '24 Mart 2024',
        'time': '10:30',
        'description': 'Kontrol randevusu',
        'isCompleted': false,
      },
      {
        'title': 'Toplantı',
        'date': '25 Mart 2024',
        'time': '15:00',
        'description': 'Proje toplantısı',
        'isCompleted': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return _buildReminderCard(
          context,
          title: reminder['title'] as String,
          date: reminder['date'] as String,
          time: reminder['time'] as String,
          description: reminder['description'] as String,
          isCompleted: reminder['isCompleted'] as bool,
        );
      },
    );
  }

  Widget _buildReminderCard(
    BuildContext context, {
    required String title,
    required String date,
    required String time,
    required String description,
    required bool isCompleted,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to reminder details
        },
        borderRadius: BorderRadius.circular(16),
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
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF2C3E50),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isCompleted ? Icons.check_circle : Icons.circle_outlined,
                      color: isCompleted
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFF2C3E50),
                    ),
                    onPressed: () {
                      // TODO: Toggle completion status
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF2C3E50).withOpacity(0.7),
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF2C3E50),
                        ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF2C3E50),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 