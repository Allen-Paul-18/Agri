import 'package:flutter/material.dart';

class BuyerHistoryPage extends StatefulWidget {
  @override
  _BuyerHistoryPageState createState() => _BuyerHistoryPageState();
}

class _BuyerHistoryPageState extends State<BuyerHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Order History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              icon: Icon(Icons.pending_actions),
              text: "Active Orders",
            ),
            Tab(
              icon: Icon(Icons.history),
              text: "Order History",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveOrdersTab(),
          _buildOrderHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersTab() {
    final activeOrders = [
      {
        'id': '#ORD001',
        'product': 'Premium Chicken',
        'weight': '5kg',
        'price': 75.00,
        'farmer': 'Green Valley Farm',
        'status': 'Processing',
        'progress': 0.3,
        'estimatedDelivery': 'Sep 13, 2025',
        'image': 'assets/chicken.jpg',
        'statusColor': Colors.orange,
      },
      {
        'id': '#ORD002',
        'product': 'Organic Pork',
        'weight': '3kg',
        'price': 45.00,
        'farmer': 'Sunshine Farm',
        'status': 'Shipped',
        'progress': 0.7,
        'estimatedDelivery': 'Sep 12, 2025',
        'image': 'assets/pork.jpg',
        'statusColor': Colors.blue,
      },
    ];

    return activeOrders.isEmpty
        ? _buildEmptyState("No active orders", "Your active orders will appear here")
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        return _buildActiveOrderCard(activeOrders[index]);
      },
    );
  }

  Widget _buildActiveOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['id'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: order['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: order['statusColor'],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Icon(Icons.restaurant, color: Colors.grey[600]),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order['product']} - ${order['weight']}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "from ${order['farmer']}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${order['price'].toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "ETA: ${order['estimatedDelivery']}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: order['progress'],
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(order['statusColor']),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _trackOrder(order['id']),
                    icon: Icon(Icons.location_on, size: 16),
                    label: Text("Track Order"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green[700],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _contactFarmer(order['farmer']),
                    icon: Icon(Icons.message, size: 16),
                    label: Text("Contact Farmer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHistoryTab() {
    final orderHistory = [
      {
        'id': '#ORD003',
        'product': 'Free-Range Chicken',
        'weight': '4kg',
        'price': 60.00,
        'farmer': 'Mountain View Farm',
        'date': 'Sep 01, 2025',
        'status': 'Delivered',
        'rating': 5,
      },
      {
        'id': '#ORD004',
        'product': 'Grass-Fed Beef',
        'weight': '2kg',
        'price': 85.00,
        'farmer': 'Prairie Ranch',
        'date': 'Aug 28, 2025',
        'status': 'Delivered',
        'rating': 4,
      },
      {
        'id': '#ORD005',
        'product': 'Organic Eggs',
        'weight': '24 pieces',
        'price': 12.00,
        'farmer': 'Sunny Side Farm',
        'date': 'Aug 25, 2025',
        'status': 'Delivered',
        'rating': 5,
      },
    ];

    return orderHistory.isEmpty
        ? _buildEmptyState("No order history", "Your completed orders will appear here")
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orderHistory.length,
      itemBuilder: (context, index) {
        return _buildHistoryOrderCard(orderHistory[index]);
      },
    );
  }

  Widget _buildHistoryOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['id'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  order['date'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: Icon(Icons.check_circle, color: Colors.green, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${order['product']} - ${order['weight']}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "from ${order['farmer']}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${order['price'].toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                            (index) => Icon(
                          Icons.star,
                          size: 12,
                          color: index < order['rating']
                              ? Colors.amber
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _reorder(order),
                    icon: Icon(Icons.refresh, size: 16),
                    label: Text("Reorder"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green[700],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewReceipt(order['id']),
                    icon: Icon(Icons.receipt, size: 16),
                    label: Text("View Receipt"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 50,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _trackOrder(String orderId) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Order Tracking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text("Order $orderId is being processed at the farm."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactFarmer(String farmerName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening chat with $farmerName..."),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  void _reorder(Map<String, dynamic> order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${order['product']} added to cart!"),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  void _viewReceipt(String orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening receipt for $orderId..."),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}