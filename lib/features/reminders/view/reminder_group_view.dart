import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/app_header.dart';
import '../services/reminder_service.dart';
import '../models/reminder.dart';
import 'package:intl/intl.dart';

class ReminderGroupView extends StatefulWidget {
  final String title;
  final String groupId;

  const ReminderGroupView({Key? key, required this.title, required this.groupId}) : super(key: key);

  @override
  State<ReminderGroupView> createState() => _ReminderGroupViewState();
}

class _ReminderGroupViewState extends State<ReminderGroupView> with TickerProviderStateMixin {
  final ReminderService _reminderService = ReminderService();
  late Future<List<Reminder>> _remindersFuture;

  final List<String> _selectedReminderIds = [];
  bool _isMultiSelectionMode = false;

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

    _remindersFuture = _reminderService.getReminders(); // Assuming getReminders fetches for a group or all
  }

  void _refreshRemindersList() {
    setState(() {
      _remindersFuture = _reminderService.getReminders();
    });
  }

  void _toggleSelectionMode() {
    setState(() {
      _isMultiSelectionMode = !_isMultiSelectionMode;
      if (!_isMultiSelectionMode) {
        _selectedReminderIds.clear(); // Clear selection when exiting mode
      }
    });
  }

  void _toggleReminderSelection(String reminderId) {
    setState(() {
      if (_selectedReminderIds.contains(reminderId)) {
        _selectedReminderIds.remove(reminderId);
      } else {
        _selectedReminderIds.add(reminderId);
      }
      // Exit multi-selection if no items are selected
      if (_selectedReminderIds.isEmpty) {
        _isMultiSelectionMode = false;
      }
    });
  }

  void _markSelectedAsCompleted() async {
    if (_selectedReminderIds.isNotEmpty) {
      // Show a loading indicator or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Marking selected reminders as completed...'),
          duration: Duration(seconds: 1),
        ),
      );

      for (final reminderId in _selectedReminderIds) {
        await _reminderService.toggleReminderCompletion(reminderId, isCompleted: true); // Ensure it's marked completed
      }

      setState(() {
        _selectedReminderIds.clear();
        _isMultiSelectionMode = false;
      });

      _refreshRemindersList(); // Refresh the list after updating

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected reminders marked as completed!'),
        ),
      );
    }
  }

  void _navigateToCreateReminder() {
    Navigator.pushNamed(context, '/create-reminder');
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
      floatingActionButton: _isMultiSelectionMode
          ? FloatingActionButton.extended(
              onPressed: _markSelectedAsCompleted,
              label: Text('Mark ${_selectedReminderIds.length} Selected as Completed'),
              icon: const Icon(Icons.check_circle_outline),
              backgroundColor: Colors.green,
            )
          : FloatingActionButton(
              onPressed: _navigateToCreateReminder,
              tooltip: 'Create Reminder',
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildReminderList({required bool isUpcoming}) {
    return FutureBuilder<List<Reminder>>(
      future: _remindersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No reminders found.'));
        } else {
          final reminders = snapshot.data!;
          // Filter for upcoming reminders if needed, currently shows all
          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              final isSelected = _selectedReminderIds.contains(reminder.id);
              return GestureDetector(
                onLongPress: () {
                  if (!_isMultiSelectionMode) {
                    _toggleSelectionMode();
                    _toggleReminderSelection(reminder.id); // Select the item on long press
                  } else {
                    _toggleReminderSelection(reminder.id);
                  }
                },
                onTap: () {
                  if (_isMultiSelectionMode) {
                    _toggleReminderSelection(reminder.id);
                  } else {
                    // Existing edit/view logic here if needed
                  }
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: isSelected ? Colors.blue.shade100 : Colors.white, // Highlight selected items
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (_isMultiSelectionMode) ...[
                          Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              _toggleReminderSelection(reminder.id);
                            },
                          ),
                          const SizedBox(width: 12),
                        ] else ...[
                          // Completion Icon (re-using existing logic)
                          InkWell(
                            onTap: () async {
                              await _reminderService.toggleReminderCompletion(reminder.id);
                              _refreshRemindersList();
                            },
                            child: Icon(
                              reminder.isCompleted
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: reminder.isCompleted ? Colors.green : Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reminder.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: reminder.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: reminder.isCompleted ? Colors.grey : Colors.black,
                                ),
                              ),
                              if (reminder.description != null && reminder.description!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    reminder.description!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: reminder.isCompleted ? Colors.grey.shade500 : Colors.grey.shade700,
                                      decoration: reminder.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Text(
                                '${DateFormat('MMM d, yyyy').format(reminder.dateTime)} at ${DateFormat('h:mm a').format(reminder.dateTime)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: reminder.isCompleted ? Colors.grey.shade500 : Colors.grey,
                                  decoration: reminder.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_isMultiSelectionMode) ...[
                           // Options Menu (Edit/Delete) - re-using existing logic
                           PopupMenuButton<String>(
                             onSelected: (value) async {
                               if (value == 'edit') {
                                 // Navigate to edit screen - assuming a route for edit
                                  // This needs to be updated to navigate to the CreateReminderView for editing
                                  // The CreateReminderView needs to be adapted to handle an existing reminder
                                  // Navigator.pushNamed(context, '/edit-reminder', arguments: reminder);
                               } else if (value == 'delete') {
                                 await _reminderService.deleteReminder(reminder.id);
                                 _refreshRemindersList();
                               }
                             },
                             itemBuilder: (BuildContext context) {
                               return ['edit', 'delete'].map((choice) {
                                 return PopupMenuItem<String>(
                                   value: choice,
                                   child: Text(choice == 'edit' ? 'Edit' : 'Delete'), // Localize these texts
                                 );
                               }).toList();
                             },
                           ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
} 