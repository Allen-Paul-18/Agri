import 'package:flutter/material.dart';

class PolicymakerAlertsPage extends StatefulWidget {
  @override
  _PolicymakerAnnouncementsPageState createState() => _PolicymakerAnnouncementsPageState();
}

class _PolicymakerAnnouncementsPageState extends State<PolicymakerAlertsPage>
    with SingleTickerProviderStateMixin {

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Form state
  String _selectedPriority = 'Medium';
  String _selectedAudience = 'All Farmers';
  String _selectedCategory = 'General';
  bool _isScheduled = false;
  DateTime? _scheduledDate;
  TimeOfDay? _scheduledTime;

  // Tab controller
  late TabController _tabController;

  // Dummy data for announcements history
  final List<Map<String, dynamic>> _announcementHistory = [
    {
      'title': 'Weather Warning: Heavy Rainfall',
      'message': 'Heavy rains expected in the next 48 hours. Please secure your livestock and equipment.',
      'priority': 'High',
      'category': 'Weather',
      'audience': 'All Farmers',
      'timestamp': DateTime.now().subtract(Duration(hours: 2)),
      'status': 'Sent',
      'recipients': 1245,
      'readRate': 87.5,
    },
    {
      'title': 'Disease Outbreak Alert',
      'message': 'Bird Flu detected in District X. Immediate quarantine measures required.',
      'priority': 'Critical',
      'category': 'Disease',
      'audience': 'Poultry Farmers',
      'timestamp': DateTime.now().subtract(Duration(days: 1)),
      'status': 'Sent',
      'recipients': 342,
      'readRate': 94.2,
    },
    {
      'title': 'Vaccination Drive Reminder',
      'message': 'Annual vaccination drive starts Monday. Register your cattle at local veterinary centers.',
      'priority': 'Medium',
      'category': 'Healthcare',
      'audience': 'Cattle Farmers',
      'timestamp': DateTime.now().subtract(Duration(days: 3)),
      'status': 'Sent',
      'recipients': 678,
      'readRate': 72.1,
    },
    {
      'title': 'New Subsidy Program Launch',
      'message': 'Government announces new subsidy program for organic farming. Applications open next week.',
      'priority': 'Medium',
      'category': 'Policy',
      'audience': 'All Farmers',
      'timestamp': DateTime.now().subtract(Duration(days: 5)),
      'status': 'Scheduled',
      'recipients': 0,
      'readRate': 0.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text("Announcements"),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.add_circle_outline),
              text: "Create Alert",
            ),
            Tab(
              icon: Icon(Icons.history),
              text: "History",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCreateAlertTab(context),
          _buildHistoryTab(context),
        ],
      ),
    );
  }

  // Create Alert Tab
  Widget _buildCreateAlertTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Actions Card
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flash_on, color: colorScheme.primary),
                      SizedBox(width: 8),
                      Text(
                        "Quick Actions",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildQuickActionChip(
                        context,
                        "Weather Alert",
                        Icons.cloud,
                        Colors.blue.shade600, // medium blue
                            () => _useQuickTemplate('weather'),
                      ),
                      _buildQuickActionChip(
                        context,
                        "Disease Outbreak",
                        Icons.warning,
                        Colors.red.shade700, // keep red for urgency
                            () => _useQuickTemplate('disease'),
                      ),
                      _buildQuickActionChip(
                        context,
                        "Vaccination",
                        Icons.medical_services,
                        Colors.blue.shade800, // dark blue
                            () => _useQuickTemplate('vaccination'),
                      ),
                      _buildQuickActionChip(
                        context,
                        "Market Update",
                        Icons.trending_up,
                        Colors.blue.shade400, // lighter blue
                            () => _useQuickTemplate('market'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Create Alert Form
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create New Announcement",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title Field
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Alert Title *",
                      hintText: "Enter a clear, descriptive title",
                      prefixIcon: Icon(Icons.title),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Priority and Category Row
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedPriority,
                          decoration: InputDecoration(
                            labelText: "Priority Level",
                            prefixIcon: Icon(Icons.flag),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: ['Low', 'Medium', 'High', 'Critical']
                              .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: _getPriorityColor(priority),
                                ),
                                SizedBox(width: 8),
                                Text(priority),
                              ],
                            ),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: "Category",
                            prefixIcon: Icon(Icons.category),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: ['General', 'Weather', 'Disease', 'Healthcare', 'Policy', 'Market']
                              .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Message Field
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Message Content *",
                      hintText: "Write a clear and actionable message...",
                      prefixIcon: Icon(Icons.message),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      counterText: "${_messageController.text.length}/500",
                    ),
                    maxLength: 500,
                    onChanged: (value) => setState(() {}),
                  ),

                  SizedBox(height: 16),

                  // Audience Selection
                  DropdownButtonFormField<String>(
                    value: _selectedAudience,
                    decoration: InputDecoration(
                      labelText: "Target Audience",
                      prefixIcon: Icon(Icons.group),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: [
                      'All Farmers',
                      'Cattle Farmers',
                      'Poultry Farmers',
                      'Crop Farmers',
                      'Dairy Farmers',
                      'Organic Farmers',
                    ].map((audience) => DropdownMenuItem(
                      value: audience,
                      child: Text(audience),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAudience = value!;
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  // Scheduling Section
                  Card(
                    color: colorScheme.surfaceVariant,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: Text("Schedule for later"),
                            subtitle: Text("Send this alert at a specific time"),
                            value: _isScheduled,
                            onChanged: (value) {
                              setState(() {
                                _isScheduled = value;
                              });
                            },
                            secondary: Icon(Icons.schedule),
                          ),
                          if (_isScheduled) ...[
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => _selectDate(context),
                                    icon: Icon(Icons.calendar_today),
                                    label: Text(_scheduledDate != null
                                        ? "${_scheduledDate!.day}/${_scheduledDate!.month}/${_scheduledDate!.year}"
                                        : "Select Date"),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => _selectTime(context),
                                    icon: Icon(Icons.access_time),
                                    label: Text(_scheduledTime != null
                                        ? _scheduledTime!.format(context)
                                        : "Select Time"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _clearForm,
                  icon: Icon(Icons.clear),
                  label: Text("Clear"),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: _canSendAlert() ? () => _sendAlert(context) : null,
                  icon: Icon(_isScheduled ? Icons.schedule_send : Icons.send),
                  label: Text(_isScheduled ? "Schedule Alert" : "Send Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 32),
        ],
      ),
    );
  }

  // History Tab
  Widget _buildHistoryTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Stats Cards
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  "Total Sent",
                  "${_announcementHistory.where((a) => a['status'] == 'Sent').length}",
                  Icons.send,
                  colorScheme.primary,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  "Scheduled",
                  "${_announcementHistory.where((a) => a['status'] == 'Scheduled').length}",
                  Icons.schedule,
                  Colors.orange,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  "Avg. Read Rate",
                  "${(_announcementHistory.map((a) => a['readRate'] as double).reduce((a, b) => a + b) / _announcementHistory.length).toStringAsFixed(1)}%",
                  Icons.visibility,
                  Colors.green,
                ),
              ),
            ],
          ),
        ),

        // Filter Section
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search announcements...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                onPressed: () => _showFilterDialog(context),
                icon: Icon(Icons.tune),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Announcements List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: _announcementHistory.length,
            itemBuilder: (context, index) {
              final announcement = _announcementHistory[index];
              return _buildAnnouncementCard(context, announcement, index);
            },
          ),
        ),
      ],
    );
  }

  // Helper Methods

  Widget _buildQuickActionChip(
      BuildContext context,
      String label,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return ActionChip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(label),
      onPressed: onPressed,
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color.withOpacity(0.3)),
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Map<String, dynamic> announcement, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final priorityColor = _getPriorityColor(announcement['priority']);

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showAnnouncementDetails(context, announcement),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: priorityColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      announcement['priority'],
                      style: TextStyle(
                        color: priorityColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      announcement['category'],
                      style: TextStyle(
                        color: colorScheme.onSecondaryContainer,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    announcement['status'] == 'Sent' ? Icons.check_circle : Icons.schedule,
                    color: announcement['status'] == 'Sent' ? Colors.green : Colors.orange,
                    size: 20,
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Title and Message
              Text(
                announcement['title'],
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                announcement['message'],
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 12),

              // Footer Info
              Row(
                children: [
                  Icon(Icons.group, size: 16, color: colorScheme.onSurfaceVariant),
                  SizedBox(width: 4),
                  Text(
                    announcement['audience'],
                    style: theme.textTheme.bodySmall,
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: colorScheme.onSurfaceVariant),
                  SizedBox(width: 4),
                  Text(
                    _formatDateTime(announcement['timestamp']),
                    style: theme.textTheme.bodySmall,
                  ),
                  Spacer(),
                  if (announcement['status'] == 'Sent')
                    Text(
                      "${announcement['readRate']}% read",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
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

  // Utility Methods

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red.shade700; // keep red for urgency
      case 'High':
        return Colors.blue.shade900;
      case 'Medium':
        return Colors.blue.shade600;
      case 'Low':
        return Colors.blue.shade400;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  bool _canSendAlert() {
    return _titleController.text.isNotEmpty && _messageController.text.isNotEmpty;
  }

  void _clearForm() {
    setState(() {
      _titleController.clear();
      _messageController.clear();
      _selectedPriority = 'Medium';
      _selectedAudience = 'All Farmers';
      _selectedCategory = 'General';
      _isScheduled = false;
      _scheduledDate = null;
      _scheduledTime = null;
    });
  }

  void _sendAlert(BuildContext context) {
    final alertData = {
      'title': _titleController.text,
      'message': _messageController.text,
      'priority': _selectedPriority,
      'category': _selectedCategory,
      'audience': _selectedAudience,
      'timestamp': _isScheduled && _scheduledDate != null
          ? DateTime(_scheduledDate!.year, _scheduledDate!.month, _scheduledDate!.day,
          _scheduledTime?.hour ?? 9, _scheduledTime?.minute ?? 0)
          : DateTime.now(),
      'status': _isScheduled ? 'Scheduled' : 'Sent',
      'recipients': _selectedAudience == 'All Farmers' ? 1245 : 456,
      'readRate': 0.0,
    };

    setState(() {
      _announcementHistory.insert(0, alertData);
    });

    _clearForm();
    _tabController.animateTo(1); // Switch to history tab

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text(_isScheduled ? "📅 Alert Scheduled Successfully!" : "📢 Alert Sent Successfully!"),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _useQuickTemplate(String type) {
    switch (type) {
      case 'weather':
        _titleController.text = "Weather Alert";
        _messageController.text = "Severe weather conditions expected. Please take necessary precautions.";
        _selectedPriority = "High";
        _selectedCategory = "Weather";
        break;
      case 'disease':
        _titleController.text = "Disease Outbreak Alert";
        _messageController.text = "Disease outbreak detected. Immediate action required.";
        _selectedPriority = "Critical";
        _selectedCategory = "Disease";
        break;
      case 'vaccination':
        _titleController.text = "Vaccination Reminder";
        _messageController.text = "Vaccination drive scheduled. Please register your animals.";
        _selectedPriority = "Medium";
        _selectedCategory = "Healthcare";
        break;
      case 'market':
        _titleController.text = "Market Update";
        _messageController.text = "Market prices updated. Check latest rates.";
        _selectedPriority = "Low";
        _selectedCategory = "Market";
        break;
    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _scheduledDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _scheduledTime = picked;
      });
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Announcements"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Filter options coming soon..."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showAnnouncementDetails(BuildContext context, Map<String, dynamic> announcement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(announcement['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(announcement['message']),
            SizedBox(height: 16),
            Text("Category: ${announcement['category']}"),
            Text("Priority: ${announcement['priority']}"),
            Text("Audience: ${announcement['audience']}"),
            Text("Recipients: ${announcement['recipients']}"),
            if (announcement['status'] == 'Sent')
              Text("Read Rate: ${announcement['readRate']}%"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}