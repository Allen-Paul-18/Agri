import 'package:flutter/material.dart';

class BuyerMarketplacePage extends StatefulWidget {
  @override
  _BuyerMarketplacePageState createState() => _BuyerMarketplacePageState();
}

class _BuyerMarketplacePageState extends State<BuyerMarketplacePage> {
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  bool _isGridView = true;
  String _selectedSort = 'Popular';

  final List<String> _categories = [
    'All',
    'Vegetables',
    'Fruits',
    'Grains',
    'Dairy',
    'Poultry',
    'Organic'
  ];

  final List<String> _sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating'
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 1,
      'name': 'Fresh Organic Tomatoes',
      'farmer': 'Green Valley Farm',
      'price': 45.0,
      'originalPrice': 60.0,
      'unit': 'per kg',
      'rating': 4.8,
      'reviews': 124,
      'image': 'https://images.unsplash.com/photo-1546470427-a5e5c0ba2e5b?w=300&h=200&fit=crop',
      'category': 'Vegetables',
      'isOrganic': true,
      'discount': 25,
      'inStock': true,
      'description': 'Premium quality organic tomatoes grown without pesticides',
      'location': '15 km away',
      'harvestDate': '2 days ago',
    },
    {
      'id': 2,
      'name': 'Farm Fresh Milk',
      'farmer': 'Dairy Dreams Co.',
      'price': 35.0,
      'originalPrice': 35.0,
      'unit': 'per litre',
      'rating': 4.9,
      'reviews': 89,
      'image': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=300&h=200&fit=crop',
      'category': 'Dairy',
      'isOrganic': false,
      'discount': 0,
      'inStock': true,
      'description': 'Pure, pasteurized milk from grass-fed cows',
      'location': '8 km away',
      'harvestDate': 'Today',
    },
    {
      'id': 3,
      'name': 'Sweet Red Apples',
      'farmer': 'Mountain Orchards',
      'price': 120.0,
      'originalPrice': 150.0,
      'unit': 'per kg',
      'rating': 4.7,
      'reviews': 203,
      'image': 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=300&h=200&fit=crop',
      'category': 'Fruits',
      'isOrganic': true,
      'discount': 20,
      'inStock': true,
      'description': 'Crispy, sweet apples perfect for snacking',
      'location': '22 km away',
      'harvestDate': '1 day ago',
    },
    {
      'id': 4,
      'name': 'Free Range Chicken',
      'farmer': 'Happy Hens Farm',
      'price': 280.0,
      'originalPrice': 320.0,
      'unit': 'per kg',
      'rating': 4.6,
      'reviews': 76,
      'image': 'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?w=300&h=200&fit=crop',
      'category': 'Poultry',
      'isOrganic': false,
      'discount': 12,
      'inStock': false,
      'description': 'Free-range chicken from antibiotic-free farms',
      'location': '12 km away',
      'harvestDate': 'Available tomorrow',
    },
    {
      'id': 5,
      'name': 'Organic Basmati Rice',
      'farmer': 'Golden Fields',
      'price': 95.0,
      'originalPrice': 95.0,
      'unit': 'per kg',
      'rating': 4.5,
      'reviews': 158,
      'image': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=300&h=200&fit=crop',
      'category': 'Grains',
      'isOrganic': true,
      'discount': 0,
      'inStock': true,
      'description': 'Premium aged basmati rice with authentic aroma',
      'location': '18 km away',
      'harvestDate': '3 days ago',
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    var filtered = _products;

    // Filter by category
    if (_selectedCategoryIndex > 0) {
      filtered = filtered.where((product) =>
      product['category'] == _categories[_selectedCategoryIndex]).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
      product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product['farmer'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with Search
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
                'Fresh Marketplace',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.sort),
                onSelected: (value) {
                  setState(() {
                    _selectedSort = value;
                  });
                },
                itemBuilder: (context) => _sortOptions.map((option) =>
                    PopupMenuItem(value: option, child: Text(option))).toList(),
              ),
            ],
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search fresh products...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                      : Icon(Icons.tune, color: Colors.grey.shade600),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(_categories[index]),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategoryIndex = index;
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

          // Products Grid/List
          _filteredProducts.isEmpty
              ? SliverToBoxAdapter(
            child: _buildEmptyState(),
          )
              : _isGridView
              ? SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildProductCard(_filteredProducts[index]),
                childCount: _filteredProducts.length,
              ),
            ),
          )
              : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildProductListItem(_filteredProducts[index]),
                childCount: _filteredProducts.length,
              ),
            ),
          ),

          // Bottom padding
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => _showProductDetails(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      image: DecorationImage(
                        image: NetworkImage(product['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (product['discount'] > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${product['discount']}% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (product['isOrganic'])
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.eco,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  if (!product['inStock'])
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Text(
                          'OUT OF STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product['farmer'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 14),
                        SizedBox(width: 2),
                        Text(
                          '${product['rating']} (${product['reviews']})',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product['discount'] > 0) ...[
                                Text(
                                  '₹${product['originalPrice'].toInt()}',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 2),
                              ],
                              Text(
                                '₹${product['price'].toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.green.shade600,
                                ),
                              ),
                              Text(
                                product['unit'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: product['inStock']
                                ? Colors.green.shade600
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            product['inStock'] ? Icons.add_shopping_cart : Icons.schedule,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showProductDetails(product),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.network(
                        product['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      if (!product['inStock'])
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.black.withOpacity(0.6),
                          child: Center(
                            child: Text(
                              'OUT OF\nSTOCK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (product['isOrganic'])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'ORGANIC',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        product['farmer'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '${product['rating']} (${product['reviews']} reviews)',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.location_on, color: Colors.grey.shade500, size: 14),
                          Text(
                            product['location'],
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          if (product['discount'] > 0) ...[
                            Text(
                              '₹${product['originalPrice'].toInt()}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                          Text(
                            '₹${product['price'].toInt()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green.shade600,
                            ),
                          ),
                          Text(
                            ' ${product['unit']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: product['inStock'] ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              product['inStock'] ? 'Add to Cart' : 'Notify Me',
                              style: TextStyle(fontSize: 12),
                            ),
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
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showProductDetails(Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
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
                // Product Image
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product['name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (product['isOrganic'])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'ORGANIC',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'By ${product['farmer']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '${product['rating']} (${product['reviews']} reviews)',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                          SizedBox(width: 16),
                          Icon(Icons.location_on, color: Colors.grey.shade500, size: 16),
                          Text(
                            product['location'],
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        product['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.schedule, color: Colors.green.shade600, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Harvested: ${product['harvestDate']}',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product['discount'] > 0) ...[
                                  Text(
                                    '₹${product['originalPrice'].toInt()}',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                ],
                                Text(
                                  '₹${product['price'].toInt()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                                Text(
                                  product['unit'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: product['inStock'] ? () {} : null,
                            icon: Icon(product['inStock'] ? Icons.add_shopping_cart : Icons.notifications),
                            label: Text(product['inStock'] ? 'Add to Cart' : 'Notify Me'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}