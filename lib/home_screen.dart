import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';
import 'models.dart';
import 'donut_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(Icons.person_outline, size: 24),
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    'I want to ',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Eat',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Categories
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: dummyCategories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryItem(index);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Grid View
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Builder(
                  builder: (context) {
                    final selectedCategoryId =
                        dummyCategories[selectedCategoryIndex].id;
                    final filteredProducts = dummyProducts
                        .where(
                          (product) => product.categoryId == selectedCategoryId,
                        )
                        .toList();

                    if (filteredProducts.isEmpty) {
                      return const Center(child: Text("No items found."));
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return _buildDonutCard(filteredProducts[index]);
                      },
                    );
                  },
                ),
              ),
            ),

            // Bottom Cart
            _buildBottomCart(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    bool isSelected = selectedCategoryIndex == index;
    // Simple icon mapping since we don't have SVGs
    IconData icon;
    switch (index) {
      case 0:
        icon = Icons.donut_large;
        break;
      case 1:
        icon = Icons.lunch_dining;
        break;
      case 2:
        icon = Icons.local_drink;
        break;
      case 3:
        icon = Icons.bakery_dining;
        break;
      case 4:
        icon = Icons.local_pizza;
        break;
      default:
        icon = Icons.fastfood;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.transparent : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? Border.all(color: Colors.black, width: 1.5)
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey[500],
                size: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dummyCategories[index].title,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutCard(Donut donut) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonutDetailsScreen(donut: donut),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: donut.backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      right: 16.0,
                      bottom: 8.0,
                    ),
                    child: Center(
                      child: donut.imagePath.endsWith('.jpg')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                donut.imagePath,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(donut.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),

                // Details Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    donut.title,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    donut.subtitle,
                    style: GoogleFonts.manrope(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),

                // Bottom Row
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.favorite_border, size: 20),
                      Text(
                        'Add',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Price Tag
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Text(
                  '\$${donut.price.toInt()}',
                  style: GoogleFonts.manrope(
                    color: donut.titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCart() {
    return Container(
      margin: const EdgeInsets.all(24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2 Items | \$45',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Delivery Charges Included',
                style: GoogleFonts.manrope(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            'View Cart',
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
