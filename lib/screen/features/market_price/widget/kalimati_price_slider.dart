import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/model/tarkari_model.dart';
import 'package:late_blight/screen/features/market_price/bloc/tarkari_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class MarketPriceSlider extends StatelessWidget {
  const MarketPriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<KalimatiTarkariBloc>().fetchProducts();
    Widget renderItem(VegAndFruit item) {
      Widget handlePrice(String label, String price) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }

      return Card(
        elevation: 3,
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${item.name} (${item.unit})",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              handlePrice("न्यूनतम", item.minPrice),
              handlePrice("अधिकतम", item.maxPrice),
              handlePrice("औसत", item.avgPrice),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<KalimatiTarkariBloc, ProductState>(
        builder: (context, state) {
      switch (state.state) {
        case RequestState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case RequestState.success:
          final items = state.vegAndFruits;
          items.shuffle();
          if (items.isEmpty) {
            return SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "बजार मूल्य",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              CarouselSlider(
                items: [
                  for (final item
                      in items.sublist(0, items.length > 5 ? 5 : items.length))
                    renderItem(item),
                ],
                disableGesture: true,
                options: CarouselOptions(
                  autoPlayCurve: Curves.easeInOutCubicEmphasized,
                  pageSnapping: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  scrollPhysics: BouncingScrollPhysics(),
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 150,
                ),
              ),
            ],
          );
        case RequestState.fail:
          return SizedBox();
        default:
          return SizedBox();
      }
    });
  }
}
