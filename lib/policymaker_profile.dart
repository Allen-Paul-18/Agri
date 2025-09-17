import 'package:flutter/material.dart';

class PolicymakerProfilePage extends StatefulWidget {
  @override
  _PolicymakerProfilePageState createState() => _PolicymakerProfilePageState();
}

class _PolicymakerProfilePageState extends State<PolicymakerProfilePage> {
  bool _notificationsEnabled = true;
  bool _alertsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with gradient background
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue.shade800,
            foregroundColor: colorScheme.onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade600,
                      Colors.blue.shade800,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      // Profile Avatar with border
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.onPrimary.withOpacity(0.2),
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: colorScheme.surface,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Name and Title
                      Text(
                        "Dr. John Doe",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Senior Policy Advisor",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        "Department of Agriculture",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Profile Content
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick Stats Card
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quick Stats",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                context,
                                "Regions Managed",
                                "12",
                                Icons.map_outlined,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                context,
                                "Alerts Sent",
                                "47",
                                Icons.notifications_outlined,
                              ),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                context,
                                "Active Farms",
                                "1,245",
                                Icons.agriculture_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Account Information Section
                Text(
                  "Account Information",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 8),

                Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      _buildInfoTile(
                        context,
                        Icons.email_outlined,
                        "Email",
                        "john.doe@agriculture.gov",
                        onTap: () => _showEditDialog(context, "Email"),
                      ),
                      Divider(height: 1),
                      _buildInfoTile(
                        context,
                        Icons.phone_outlined,
                        "Phone",
                        "+1 (555) 123-4567",
                        onTap: () => _showEditDialog(context, "Phone"),
                      ),
                      Divider(height: 1),
                      _buildInfoTile(
                        context,
                        Icons.location_on_outlined,
                        "Office Location",
                        "Washington, DC",
                        onTap: () => _showEditDialog(context, "Location"),
                      ),
                      Divider(height: 1),
                      _buildInfoTile(
                        context,
                        Icons.badge_outlined,
                        "Employee ID",
                        "AGR-2024-001",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Settings Section
                Text(
                  "Preferences",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 8),

                Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        context,
                        Icons.notifications_outlined,
                        "Push Notifications",
                        "Receive alerts and updates",
                        _notificationsEnabled,
                            (value) => setState(() => _notificationsEnabled = value),
                      ),
                      Divider(height: 1),
                      _buildSwitchTile(
                        context,
                        Icons.warning_outlined,
                        "Emergency Alerts",
                        "Receive urgent outbreak notifications",
                        _alertsEnabled,
                            (value) => setState(() => _alertsEnabled = value),
                      ),
                      Divider(height: 1),
                      _buildSettingsTile(
                        context,
                        Icons.lock_outline,
                        "Change Password",
                        "Update your account password",
                        onTap: () => _showPasswordDialog(context),
                      ),
                      Divider(height: 1),
                      _buildSettingsTile(
                        context,
                        Icons.language_outlined,
                        "Language",
                        "English (US)",
                        onTap: () => _showLanguageDialog(context),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Support Section
                Text(
                  "Support & Help",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 8),

                Card(
                  elevation: 1,
                  child: Column(
                    children: [
                      _buildSettingsTile(
                        context,
                        Icons.help_outline,
                        "Help Center",
                        "Get help and support",
                        onTap: () => _showSnackBar(context, "Opening Help Center..."),
                      ),
                      Divider(height: 1),
                      _buildSettingsTile(
                        context,
                        Icons.feedback_outlined,
                        "Send Feedback",
                        "Share your thoughts with us",
                        onTap: () => _showSnackBar(context, "Opening Feedback Form..."),
                      ),
                      Divider(height: 1),
                      _buildSettingsTile(
                        context,
                        Icons.info_outline,
                        "About",
                        "App version 2.1.0",
                        onTap: () => _showAboutDialog(context),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showLogoutDialog(context),
                    icon: Icon(Icons.logout),
                    label: Text("Sign Out"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build stat items
  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 24),
        SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper method to build info tiles
  Widget _buildInfoTile(
      BuildContext context,
      IconData icon,
      String title,
      String value, {
        VoidCallback? onTap,
      }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title),
      subtitle: Text(value),
      trailing: onTap != null ? Icon(Icons.edit_outlined, size: 20) : null,
      onTap: onTap,
    );
  }

  // Helper method to build switch tiles
  Widget _buildSwitchTile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      bool value,
      ValueChanged<bool> onChanged,
      ) {
    final theme = Theme.of(context);

    return SwitchListTile(
      secondary: Icon(icon, color: Colors.blue.shade700),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  // Helper method to build settings tiles
  Widget _buildSettingsTile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle, {
        VoidCallback? onTap,
      }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // Dialog methods
  void _showEditDialog(BuildContext context, String field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          decoration: InputDecoration(
            labelText: field,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar(context, "$field updated successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Current Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm New Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar(context, "Password updated successfully");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text("English (US)"),
              value: "en_US",
              groupValue: "en_US",
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile<String>(
              title: Text("Spanish (ES)"),
              value: "es_ES",
              groupValue: "en_US",
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile<String>(
              title: Text("French (FR)"),
              value: "fr_FR",
              groupValue: "en_US",
              onChanged: (value) => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out of your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout logic here
              _showSnackBar(context, "Signed out successfully");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "Farm Management",
      applicationVersion: "2.1.0",
      applicationIcon: Icon(Icons.agriculture, size: 48),
      children: [
        Text("Digital Farm Management System for policymakers."),
        SizedBox(height: 8),
        Text("© 2024 Department of Agriculture"),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}