import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';

class DonutDetailsScreen extends StatelessWidget {
  final Donut donut;

  const DonutDetailsScreen({super.key, required this.donut});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF8F4), // Same as Home background
      body: SafeArea(
        child: Column(
          children: [
            // Top Appbar & Image Section
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  // Back Button & Title
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, size: 28),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          donut.title,
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Hero Image
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0, bottom: 20),
                      child: donut.imagePath.endsWith('.jpg')
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                donut.imagePath,
                                fit: BoxFit.cover,
                                width: 250,
                                height: 250,
                              ),
                            )
                          : Image.asset(donut.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Details Sheet
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ingredients',
                              style: GoogleFonts.manrope(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Ingredients Row - Make it scrollable in case it overflows on small screens
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: donut.ingredients
                                    .map(
                                      (ingredient) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12.0,
                                        ),
                                        child: _buildIngredientItem(ingredient),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),

                            const SizedBox(height: 30),
                            Text(
                              'Details',
                              style: GoogleFonts.manrope(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              donut.description,
                              style: GoogleFonts.manrope(
                                color: Colors.grey[700],
                                height: 1.5,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Bottom Add to Cart Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
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
                                '\$${donut.price}',
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Delivery Not Included',
                                style: GoogleFonts.manrope(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Add to Cart',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildIngredientItem(Ingredient ingredient) {
    return Container(
      width: 80, // Fixed width to ensure pills are uniform
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40), // Pill shape
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Text(
            ingredient.name,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ingredient.amount,
            style: GoogleFonts.manrope(color: Colors.grey[500], fontSize: 10),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ingredient.color,
              shape: BoxShape.circle,
            ),
            child: Text(
              ingredient.percentage < 1
                  ? '.${(ingredient.percentage * 10).toInt()}%'
                  : '${ingredient.percentage.toInt()}%',
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
