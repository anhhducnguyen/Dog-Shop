import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerSlider extends StatefulWidget {
  final List<String> images;
  final Function(int) onPageChanged;

  BannerSlider({required this.images, required this.onPageChanged});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 150.0,
            aspectRatio: 1,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Update the current index when page changes
              });
              widget.onPageChanged(index);
            },
          ),
          items: widget.images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width, // Set width to screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Ensure rounded corners are applied to the image
                    child: Image.asset(i, fit: BoxFit.cover), // Ensure the image covers the entire width
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return Container(
              width: 7.0,
              height: 7.0,
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key ? Colors.orange[600] : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
