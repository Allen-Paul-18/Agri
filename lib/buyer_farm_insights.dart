import 'package:flutter/material.dart';

class BuyerFarmInsightsPage extends StatefulWidget {
  @override
  _BuyerFarmInsightsPageState createState() => _BuyerFarmInsightsPageState();
}

class _BuyerFarmInsightsPageState extends State<BuyerFarmInsightsPage> {
  int _selectedTab = 0;
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Organic', 'Conventional', 'Nearby', 'Premium'];
  final List<String> _tabs = ['Overview', 'Health', 'Certifications'];

  final List<Map<String, dynamic>> _farms = [
    {
      'id': 1,
      'name': 'Green Valley Organic Farm',
      'farmer': 'Rajesh Kumar',
      'image': 'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?w=400&h=300&fit=crop',
      'location': '12 km away • Karnataka',
      'type': 'Organic',
      'rating': 4.9,
      'reviews': 156,
      'established': '2018',
      'area': '25 acres',
      'healthScore': 95,
      'vaccinationStatus': 'Up to date',
      'lastInspection': '2 days ago',
      'certifications': ['Organic India', 'Fair Trade', 'ISO 9001'],
      'specialties': ['Vegetables', 'Fruits', 'Herbs'],
      'biosecurityLevel': 'Excellent',
      'environmentalScore': 92,
      'animalWelfare': 88,
      'soilHealth': 'Excellent',
      'waterQuality': 'Pure',
      'pesticideUse': 'None',
      'description': 'A certified organic farm committed to sustainable agriculture practices and environmental conservation.',
      'products': 23,
      'buyers': 89,
      'totalHarvest': '2.3 tons this month',
      'weatherImpact': 'Favorable',
    },
    {
      'id': 2,
      'name': 'Sunrise Dairy Collective',
      'farmer': 'Meena Patel',
      'image': 'https://images.unsplash.com/photo-1560493676-04071c5f467b?w=400&h=300&fit=crop',
      'location': '8 km away • Gujarat',
      'type': 'Conventional',
      'rating': 4.7,
      'reviews': 203,
      'established': '2015',
      'area': '40 acres',
      'healthScore': 88,
      'vaccinationStatus': 'Current',
      'lastInspection': '1 week ago',
      'certifications': ['FSSAI', 'ISO 22000'],
      'specialties': ['Dairy', 'Milk Products'],
      'biosecurityLevel': 'Good',
      'environmentalScore': 85,
      'animalWelfare': 90,
      'soilHealth': 'Good',
      'waterQuality': 'Good',
      'pesticideUse': 'Minimal',
      'description': 'Modern dairy farm focusing on high-quality milk production with ethical animal care practices.',
      'products': 8,
      'buyers': 145,
      'totalHarvest': '1200 L daily',
      'weatherImpact': 'Stable',
    },
    {
      'id': 3,
      'name': 'Mountain View Poultry',
      'farmer': 'Arjun Singh',
      'image': 'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?w=400&h=300&fit=crop',
      'location': '15 km away • Himachal Pradesh',
      'type': 'Premium',
      'rating': 4.6,
      'reviews': 87,
      'established': '2020',
      'area': '15 acres',
      'healthScore': 91,
      'vaccinationStatus': 'Complete',
      'lastInspection': '3 days ago',
      'certifications': ['Free Range', 'Antibiotic Free'],
      'specialties': ['Free Range Eggs', 'Chicken'],
      'biosecurityLevel': 'Very Good',
      'environmentalScore': 89,
      'animalWelfare': 95,
      'soilHealth': 'Very Good',
      'waterQuality': 'Excellent',
      'pesticideUse': 'None',
      'description': 'Premium free-range poultry farm with focus on natural feeding and humane animal treatment.',
      'products': 12,
      'buyers': 67,
      'totalHarvest': '500 eggs daily',
      'weatherImpact': 'Good',
    },
  ];

  List<Map<String, dynamic>> get _filteredFarms {
    if (_selectedFilter == 'All') return _farms;
    return _farms.where((farm) => farm['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 120.0,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.green.shade600,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                      Colors.teal.shade500,
                    ],
                  ),
                ),
              ),
              title: Text(
                'Farm Transparency Hub',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.tune),
                onPressed: () {},
              ),
            ],
          ),

          // Stats Overview
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.agriculture,
                      title: "Partner Farms",
                      value: "${_farms.length}",
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.verified,
                      title: "Certified",
                      value: "${_farms.where((f) => f['certifications'].length > 2).length}",
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.eco,
                      title: "Organic",
                      value: "${_farms.where((f) => f['type'] == 'Organic').length}",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter Tabs
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == _filters[index];
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(_filters[index]),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = _filters[index];
                        });
                      },
                      backgroundColor: Colors.grey.shade100,
                      selectedColor: Colors.green.shade100,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.green.shade700 : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.green.shade300 : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Farms List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildFarmCard(_filteredFarms[index]),
              childCount: _filteredFarms.length,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
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
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFarmCard(Map<String, dynamic> farm) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showFarmDetails(farm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Farm Image Header
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      farm['image'],
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(farm['type']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        farm['type'].toString().toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 14),
                          SizedBox(width: 2),
                          Text(
                            farm['rating'].toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Farm Info
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                farm['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'By ${farm['farmer']}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getHealthColor(farm['healthScore']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${farm['healthScore']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getHealthColor(farm['healthScore']),
                                ),
                              ),
                              Text(
                                'Health',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.grey.shade500),
                        SizedBox(width: 4),
                        Text(
                          farm['location'],
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                        SizedBox(width: 4),
                        Text(
                          'Est. ${farm['established']}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // Quick Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickStat(
                            icon: Icons.grass,
                            label: 'Area',
                            value: farm['area'],
                          ),
                        ),
                        Expanded(
                          child: _buildQuickStat(
                            icon: Icons.shopping_basket,
                            label: 'Products',
                            value: farm['products'].toString(),
                          ),
                        ),
                        Expanded(
                          child: _buildQuickStat(
                            icon: Icons.people,
                            label: 'Buyers',
                            value: farm['buyers'].toString(),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Health Indicators
                    Row(
                      children: [
                        _buildHealthIndicator(
                          icon: Icons.vaccines,
                          label: 'Vaccination',
                          status: farm['vaccinationStatus'],
                          color: Colors.green,
                        ),
                        SizedBox(width: 12),
                        _buildHealthIndicator(
                          icon: Icons.security,
                          label: 'Biosecurity',
                          status: farm['biosecurityLevel'],
                          color: Colors.blue,
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Certifications
                    if (farm['certifications'].isNotEmpty) ...[
                      Text(
                        'Certifications',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: (farm['certifications'] as List).take(3).map<Widget>((cert) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Text(
                                cert,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ).toList(),
                      ),
                      if (farm['certifications'].length > 3)
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            '+${farm['certifications'].length - 3} more',
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            farm['description'],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade500),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthIndicator({
    required IconData icon,
    required String label,
    required String status,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: color,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Organic':
        return Colors.green.shade600;
      case 'Premium':
        return Colors.purple.shade600;
      case 'Conventional':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getHealthColor(int score) {
    if (score >= 90) return Colors.green.shade600;
    if (score >= 80) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  void _showFarmDetails(Map<String, dynamic> farm) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                ),

                // Farm Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    farm['image'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  farm['name'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Managed by ${farm['farmer']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _getHealthColor(farm['healthScore']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${farm['healthScore']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _getHealthColor(farm['healthScore']),
                                  ),
                                ),
                                Text(
                                  'Health Score',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Tab Navigation
                      Container(
                        height: 40,
                        child: Row(
                          children: _tabs.asMap().entries.map((entry) {
                            int index = entry.key;
                            String tab = entry.value;
                            bool isSelected = _selectedTab == index;

                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTab = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.green.shade600 : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      tab,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.grey.shade600,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Tab Content
                      _buildTabContent(farm),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(Map<String, dynamic> farm) {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab(farm);
      case 1:
        return _buildHealthTab(farm);
      case 2:
        return _buildCertificationsTab(farm);
      default:
        return Container();
    }
  }

  Widget _buildOverviewTab(Map<String, dynamic> farm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Farm Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          farm['description'],
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
        SizedBox(height: 16),

        // Key Metrics
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildMetricRow('Total Area', farm['area']),
              _buildMetricRow('Established', farm['established']),
              _buildMetricRow('Total Products', '${farm['products']} varieties'),
              _buildMetricRow('Active Buyers', '${farm['buyers']} customers'),
              _buildMetricRow('Monthly Harvest', farm['totalHarvest']),
              _buildMetricRow('Weather Impact', farm['weatherImpact']),
            ],
          ),
        ),

        SizedBox(height: 16),

        Text(
          'Specialties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: (farm['specialties'] as List).map<Widget>((specialty) =>
              Chip(
                label: Text(specialty),
                backgroundColor: Colors.green.shade100,
                labelStyle: TextStyle(color: Colors.green.shade700),
              ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildHealthTab(Map<String, dynamic> farm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health & Safety Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        // Health Scores
        _buildHealthMetric('Overall Health Score', farm['healthScore'], 100),
        _buildHealthMetric('Environmental Score', farm['environmentalScore'], 100),
        _buildHealthMetric('Animal Welfare', farm['animalWelfare'], 100),

        SizedBox(height: 20),

        // Health Details
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildHealthDetail('Soil Health', farm['soilHealth']),
              _buildHealthDetail('Water Quality', farm['waterQuality']),
              _buildHealthDetail('Pesticide Use', farm['pesticideUse']),
              _buildHealthDetail('Vaccination Status', farm['vaccinationStatus']),
              _buildHealthDetail('Biosecurity Level', farm['biosecurityLevel']),
              _buildHealthDetail('Last Inspection', farm['lastInspection']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationsTab(Map<String, dynamic> farm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications & Standards',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        ...(farm['certifications'] as List).map<Widget>((cert) =>
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.verified,
                      color: Colors.green.shade600,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Valid until 2025',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
        ).toList(),

        SizedBox(height: 16),

        // Compliance Score
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade50, Colors.blue.shade50],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.security, color: Colors.green.shade600),
                  SizedBox(width: 8),
                  Text(
                    'Compliance Score',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '94%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 0.94,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
              ),
              SizedBox(height: 8),
              Text(
                'Meets all major food safety and quality standards',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String title, int score, int maxScore) {
    double percentage = score / maxScore;
    Color color = _getHealthColor(score);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                '$score/$maxScore',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}