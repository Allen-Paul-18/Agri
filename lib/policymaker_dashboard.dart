import 'package:flutter/material.dart';

class PolicymakerDashboardPage extends StatefulWidget {
  @override
  _PolicymakerDashboardPageState createState() => _PolicymakerDashboardPageState();
}

class _PolicymakerDashboardPageState extends State<PolicymakerDashboardPage> {
  String selectedRegion = "All Regions";
  String selectedAnimalType = "All Animals";
  String selectedTimeframe = "Last 30 Days";

  final List<String> regions = [
    "All Regions", "Central Valley", "North District",
    "Highland Region", "East Valley", "West Plains"
  ];

  final List<String> animalTypes = [
    "All Animals", "Dairy Cattle", "Poultry",
    "Mixed Livestock", "Sheep", "Swine"
  ];

  final List<String> timeframes = [
    "Last 7 Days", "Last 30 Days", "Last 90 Days", "Last Year"
  ];

  // Dummy data for demonstration
  final List<Map<String, dynamic>> recentAlerts = [
    {
      "title": "H5N1 Outbreak Detected",
      "location": "North District - Sector 8B",
      "severity": "high",
      "time": "2 hours ago",
      "affected": "12 farms",
    },
    {
      "title": "Compliance Warning Issued",
      "location": "Central Valley - Sector 12A",
      "severity": "medium",
      "time": "4 hours ago",
      "affected": "3 farms",
    },
    {
      "title": "Vaccination Campaign Completed",
      "location": "East Valley - Sector 6D",
      "severity": "low",
      "time": "1 day ago",
      "affected": "45 farms",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Regional Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Dashboard data refreshed"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            tooltip: "Refresh Data",
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showFilterDialog(context);
            },
            tooltip: "Filter Settings",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate data refresh
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Stats Cards Row
              _buildQuickStatsSection(),
              SizedBox(height: 20),

              // Disease Spread Heatmap Section
              _buildHeatmapSection(),
              SizedBox(height: 20),

              // Charts Section
              _buildChartsSection(),
              SizedBox(height: 20),

              // Recent Alerts & Activity
              _buildRecentAlertsSection(),
              SizedBox(height: 20),

              // Regional Summary
              _buildRegionalSummarySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard("Active Outbreaks", "5", "🦠", Colors.red, "+2 today")),
            SizedBox(width: 12),
            Expanded(child: _buildStatCard("Farms Monitored", "1,247", "🏭", Colors.blue, "98% active")),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard("Compliance Rate", "84.2%", "✅", Colors.green, "+2.1% this month")),
            SizedBox(width: 12),
            Expanded(child: _buildStatCard("Risk Level", "Medium", "⚠️", Colors.orange, "Stable")),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String emoji, Color color, String subtitle) {
    return Container(
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
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 24)),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapSection() {
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
              Icon(Icons.map, color: Colors.blue[600], size: 24),
              SizedBox(width: 8),
              Text(
                "Disease Spread Heatmap",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Opening full screen heatmap...")),
                  );
                },
                icon: Icon(Icons.fullscreen, size: 16),
                label: Text("Expand"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green[100]!,
                  Colors.yellow[100]!,
                  Colors.red[100]!,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: _buildHeatmapDot(Colors.green, "Central Valley\nLow Risk"),
                ),
                Positioned(
                  top: 50,
                  right: 30,
                  child: _buildHeatmapDot(Colors.red, "North District\nHigh Risk"),
                ),
                Positioned(
                  bottom: 40,
                  left: 50,
                  child: _buildHeatmapDot(Colors.orange, "East Valley\nMedium Risk"),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: _buildHeatmapDot(Colors.green, "West Plains\nLow Risk"),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.map_outlined, size: 48, color: Colors.grey[400]),
                      SizedBox(height: 8),
                      Text(
                        "Interactive Heatmap",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Tap to explore regions",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(Colors.green, "Low Risk", "0-2 cases"),
              _buildLegendItem(Colors.orange, "Medium Risk", "3-8 cases"),
              _buildLegendItem(Colors.red, "High Risk", "9+ cases"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapDot(Color color, String label) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Viewing details for: ${label.split('\n')[0]}")),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 9,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildChartCard(
            "Outbreak Trends",
            Icons.trending_up,
            Colors.red,
            "📈 Chart Placeholder\n\n7-day trend: ↗️ +15%\nPeak: North District\nRecovery rate: 78%",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildChartCard(
            "Compliance Score",
            Icons.assessment,
            Colors.blue,
            "📊 Chart Placeholder\n\nAverage: 84.2%\nBest: Central Valley (92%)\nNeeds attention: 3 regions",
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(String title, IconData icon, Color color, String placeholder) {
    return Container(
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
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Center(
              child: Text(
                placeholder,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAlertsSection() {
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
              Icon(Icons.notifications_active, color: Colors.orange[600]),
              SizedBox(width: 8),
              Text(
                "Recent Alerts & Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Opening full alerts page...")),
                  );
                },
                child: Text("View All"),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...recentAlerts.map((alert) => _buildAlertItem(alert)).toList(),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor;
    IconData severityIcon;

    switch (alert["severity"]) {
      case "high":
        severityColor = Colors.red;
        severityIcon = Icons.error;
        break;
      case "medium":
        severityColor = Colors.orange;
        severityIcon = Icons.warning;
        break;
      default:
        severityColor = Colors.green;
        severityIcon = Icons.info;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: severityColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(severityIcon, color: severityColor, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert["title"],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  alert["location"],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                alert["time"],
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 11,
                ),
              ),
              SizedBox(height: 2),
              Text(
                alert["affected"],
                style: TextStyle(
                  color: severityColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionalSummarySection() {
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
          Text(
            "Regional Performance",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildRegionRow("Central Valley", 92, Colors.green, "1,247 farms", "2 active cases"),
          _buildRegionRow("North District", 67, Colors.orange, "892 farms", "12 active cases"),
          _buildRegionRow("Highland Region", 88, Colors.green, "654 farms", "1 active case"),
          _buildRegionRow("East Valley", 85, Colors.green, "789 farms", "0 active cases"),
          _buildRegionRow("West Plains", 74, Colors.orange, "445 farms", "3 active cases"),
        ],
      ),
    );
  }

  Widget _buildRegionRow(String region, int score, Color color, String farms, String cases) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  farms,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  "$score%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 4,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: score / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cases,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text("Dashboard Filters"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedRegion,
                    decoration: InputDecoration(labelText: "Region"),
                    items: regions.map((region) => DropdownMenuItem(
                      value: region,
                      child: Text(region),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value!;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedAnimalType,
                    decoration: InputDecoration(labelText: "Animal Type"),
                    items: animalTypes.map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAnimalType = value!;
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedTimeframe,
                    decoration: InputDecoration(labelText: "Timeframe"),
                    items: timeframes.map((timeframe) => DropdownMenuItem(
                      value: timeframe,
                      child: Text(timeframe),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTimeframe = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    this.setState(() {}); // Refresh the main widget
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Filters applied successfully")),
                    );
                  },
                  child: Text("Apply"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}