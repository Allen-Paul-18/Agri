import 'package:flutter/material.dart';
import 'policymaker_dashboard.dart';
import 'policymaker_compliance.dart';
import 'policymaker_alerts.dart';
import 'policymaker_profile.dart';

class PolicymakerHomePage extends StatefulWidget {
  @override
  _PolicymakerHomePageState createState() => _PolicymakerHomePageState();
}

class _PolicymakerHomePageState extends State<PolicymakerHomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2; // Center = Home
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Home page content widget
  late Widget _homeContent;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    _homeContent = PolicymakerHomeContent(
      onNavigate: (index) => _onItemTapped(index),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    PolicymakerDashboardPage(),
    PolicymakerCompliancePage(),
    Container(), // Will be replaced with home content
    PolicymakerAlertsPage(),
    PolicymakerProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 2
          ? FadeTransition(
        opacity: _fadeAnimation,
        child: _homeContent,
      )
          : _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue[600],
          unselectedItemColor: Colors.grey[500],
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.dashboard_outlined, Icons.dashboard, 0),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.assessment_outlined, Icons.assessment, 1),
              label: "Compliance",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home_outlined, Icons.home, 2),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.campaign_outlined, Icons.campaign, 3),
              label: "Alerts",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person_outline, Icons.person, 4),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData outlinedIcon, IconData filledIcon, int index) {
    bool isSelected = _selectedIndex == index;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[600]!.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        size: isSelected ? 26 : 24,
      ),
    );
  }
}

class PolicymakerHomeContent extends StatelessWidget {
  final Function(int) onNavigate;

  const PolicymakerHomeContent({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[600]!,
                Colors.blue[800]!,
              ],
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, Dr. Smith",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Regional Health Policy Director",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () => onNavigate(3),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Stats Summary
              _buildQuickStatsSummary(),
              SizedBox(height: 20),

              // Critical Alerts Section
              _buildCriticalAlertsSection(),
              SizedBox(height: 20),

              // Quick Actions Grid
              _buildQuickActionsSection(context),
              SizedBox(height: 20),

              // Recent Activity
              _buildRecentActivitySection(),
              SizedBox(height: 20),

              // Regional Overview
              _buildRegionalOverviewSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.analytics, color: Colors.blue[600], size: 20),
              ),
              SizedBox(width: 12),
              Text(
                "Today's Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildMiniStatCard("Active Cases", "47", Colors.red, Icons.coronavirus),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildMiniStatCard("New Reports", "12", Colors.orange, Icons.report),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildMiniStatCard("Compliance", "84.2%", Colors.green, Icons.check_circle),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: Colors.blue[600], size: 16),
                SizedBox(width: 8),
                Text(
                  "Overall health index improved by 3.2% this week",
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalAlertsSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red[50]!,
            Colors.orange[50]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.priority_high, color: Colors.white, size: 16),
              ),
              SizedBox(width: 12),
              Text(
                "Critical Alerts",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[800],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "3 NEW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildAlertItem(
            "H5N1 Outbreak - North District",
            "12 farms affected • Immediate action required",
            Icons.coronavirus,
            Colors.red,
            "2 hours ago",
          ),
          SizedBox(height: 8),
          _buildAlertItem(
            "Compliance Deadline Approaching",
            "67 farms need to submit reports by tomorrow",
            Icons.schedule,
            Colors.orange,
            "4 hours ago",
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onNavigate(3),
              icon: Icon(Icons.visibility, size: 16),
              label: Text("View All Alerts"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String subtitle, IconData icon, Color color, String time) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildQuickActionCard(
              "View Dashboard",
              "Regional health metrics",
              Icons.dashboard,
              Colors.blue,
                  () => onNavigate(0),
            ),
            _buildQuickActionCard(
              "Check Compliance",
              "Farm compliance reports",
              Icons.assessment,
              Colors.green,
                  () => onNavigate(1),
            ),
            _buildQuickActionCard(
              "Send Alert",
              "Emergency notifications",
              Icons.campaign,
              Colors.orange,
                  () => onNavigate(3),
            ),
            _buildQuickActionCard(
              "Generate Report",
              "Export data & analytics",
              Icons.file_download,
              Colors.purple,
                  () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Generating comprehensive report...")),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: Colors.blue[600], size: 20),
              SizedBox(width: 8),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildActivityItem(
            "Compliance report generated for Central Valley",
            "15 minutes ago",
            Icons.description,
            Colors.blue,
          ),
          _buildActivityItem(
            "Emergency alert sent to North District",
            "2 hours ago",
            Icons.notifications,
            Colors.red,
          ),
          _buildActivityItem(
            "Weekly health summary reviewed",
            "1 day ago",
            Icons.check_circle,
            Colors.green,
          ),
          _buildActivityItem(
            "Policy update published to all regions",
            "2 days ago",
            Icons.policy,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 14),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalOverviewSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.map, color: Colors.green[600], size: 20),
              SizedBox(width: 8),
              Text(
                "Regional Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => onNavigate(0),
                child: Text("View Details"),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildRegionSummaryCard("North District", "67%", Colors.orange, "⚠️"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildRegionSummaryCard("Central Valley", "92%", Colors.green, "✅"),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildRegionSummaryCard("East Valley", "85%", Colors.green, "✅"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildRegionSummaryCard("West Plains", "74%", Colors.orange, "⚠️"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionSummaryCard(String region, String score, Color color, String emoji) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 16)),
              Spacer(),
              Text(
                score,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            region,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}