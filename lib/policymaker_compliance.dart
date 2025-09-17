import 'package:flutter/material.dart';

class PolicymakerCompliancePage extends StatefulWidget {
  @override
  _PolicymakerCompliancePageState createState() => _PolicymakerCompliancePageState();
}

class _PolicymakerCompliancePageState extends State<PolicymakerCompliancePage> {
  // Enhanced dummy data with more realistic farm information
  final List<Map<String, dynamic>> farms = [
    {
      "name": "Greenfield Dairy Farm",
      "owner": "John Smith",
      "district": "Central Valley",
      "animalType": "Dairy Cattle",
      "complianceScore": 92,
      "status": "compliant",
      "lastInspection": "2024-08-15",
      "issues": 2,
      "location": "Sector 12-A"
    },
    {
      "name": "Sunrise Poultry Ranch",
      "owner": "Maria Garcia",
      "district": "North District",
      "animalType": "Poultry",
      "complianceScore": 78,
      "status": "warning",
      "lastInspection": "2024-08-20",
      "issues": 5,
      "location": "Sector 8-B"
    },
    {
      "name": "Mountain View Livestock",
      "owner": "David Chen",
      "district": "Highland Region",
      "animalType": "Mixed Livestock",
      "complianceScore": 45,
      "status": "critical",
      "lastInspection": "2024-08-10",
      "issues": 12,
      "location": "Sector 15-C"
    },
    {
      "name": "Riverside Sheep Farm",
      "owner": "Ahmed Hassan",
      "district": "East Valley",
      "animalType": "Sheep",
      "complianceScore": 88,
      "status": "compliant",
      "lastInspection": "2024-08-25",
      "issues": 3,
      "location": "Sector 6-D"
    },
    {
      "name": "Golden Acres Pig Farm",
      "owner": "Sarah Johnson",
      "district": "West Plains",
      "animalType": "Swine",
      "complianceScore": 65,
      "status": "warning",
      "lastInspection": "2024-08-12",
      "issues": 8,
      "location": "Sector 9-A"
    },
  ];

  String selectedDistrict = "All Districts";
  String selectedAnimalType = "All Animals";
  List<Map<String, dynamic>> filteredFarms = [];

  final List<String> districts = [
    "All Districts",
    "Central Valley",
    "North District",
    "Highland Region",
    "East Valley",
    "West Plains"
  ];

  final List<String> animalTypes = [
    "All Animals",
    "Dairy Cattle",
    "Poultry",
    "Mixed Livestock",
    "Sheep",
    "Swine"
  ];

  @override
  void initState() {
    super.initState();
    filteredFarms = farms;
  }

  void _filterFarms() {
    setState(() {
      filteredFarms = farms.where((farm) {
        bool matchesDistrict = selectedDistrict == "All Districts" ||
            farm["district"] == selectedDistrict;
        bool matchesAnimal = selectedAnimalType == "All Animals" ||
            farm["animalType"] == selectedAnimalType;
        return matchesDistrict && matchesAnimal;
      }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'compliant':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'compliant':
        return Icons.check_circle;
      case 'warning':
        return Icons.warning;
      case 'critical':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'compliant':
        return 'Compliant';
      case 'warning':
        return 'Warning';
      case 'critical':
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Compliance Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          // Export/Download button as requested
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Exporting compliance report..."),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: Icon(Icons.download),
            tooltip: "Export Report",
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Statistics Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
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
                  "Regional Overview",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard("Total Farms", "${filteredFarms.length}", Colors.blue),
                    _buildStatCard("Compliant", "${filteredFarms.where((f) => f['status'] == 'compliant').length}", Colors.green),
                    _buildStatCard("Warnings", "${filteredFarms.where((f) => f['status'] == 'warning').length}", Colors.orange),
                    _buildStatCard("Critical", "${filteredFarms.where((f) => f['status'] == 'critical').length}", Colors.red),
                  ],
                ),
              ],
            ),
          ),

          // Filters Section
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedDistrict,
                    decoration: InputDecoration(
                      labelText: "District",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: districts.map((district) => DropdownMenuItem(
                      value: district,
                      child: Text(district),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value!;
                        _filterFarms();
                      });
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedAnimalType,
                    decoration: InputDecoration(
                      labelText: "Animal Type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: animalTypes.map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    )).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAnimalType = value!;
                        _filterFarms();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Farm List
          Expanded(
            child: filteredFarms.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    "No farms match the selected filters",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredFarms.length,
              itemBuilder: (context, index) {
                final farm = filteredFarms[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
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
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(farm["status"]).withOpacity(0.1),
                      child: Icon(
                        _getStatusIcon(farm["status"]),
                        color: _getStatusColor(farm["status"]),
                      ),
                    ),
                    title: Text(
                      farm["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("Owner: ${farm["owner"]}"),
                        Text("${farm["district"]} • ${farm["animalType"]}"),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(farm["status"]).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${_getStatusText(farm["status"])} • ${farm["complianceScore"]}%",
                                style: TextStyle(
                                  color: _getStatusColor(farm["status"]),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${farm["issues"]} issues",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                    onTap: () {
                      // Show detailed farm compliance dialog
                      _showFarmDetailsDialog(context, farm);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
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
      ],
    );
  }

  void _showFarmDetailsDialog(BuildContext context, Map<String, dynamic> farm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(
                _getStatusIcon(farm["status"]),
                color: _getStatusColor(farm["status"]),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  farm["name"],
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Owner", farm["owner"]),
              _buildDetailRow("District", farm["district"]),
              _buildDetailRow("Animal Type", farm["animalType"]),
              _buildDetailRow("Location", farm["location"]),
              _buildDetailRow("Compliance Score", "${farm["complianceScore"]}%"),
              _buildDetailRow("Issues Found", "${farm["issues"]}"),
              _buildDetailRow("Last Inspection", farm["lastInspection"]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Opening detailed compliance report...")),
                );
              },
              child: Text("View Full Report"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}