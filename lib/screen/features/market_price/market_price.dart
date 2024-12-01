import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/features/market_price/bloc/tarkari_bloc.dart';
import 'package:late_blight/utils/enums.dart';

class KaliMatiTarkariPrice extends StatefulWidget {
  const KaliMatiTarkariPrice({super.key});

  @override
  State<KaliMatiTarkariPrice> createState() => _KaliMatiTarkariPriceState();
}

class _KaliMatiTarkariPriceState extends State<KaliMatiTarkariPrice> {
  @override
  void initState() {
    super.initState();
    context.read<KalimatiTarkariBloc>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    Widget handleValue(String value) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    Widget handleHeader(String value) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                color: Colors.green[100],
                child: SizedBox(
                  width: Size.infinite.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'दैनिक मूल्य बारे जानकारी',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<KalimatiTarkariBloc, ProductState>(
              builder: (context, state) {
                if (state.state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.state == RequestState.fail) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state.vegAndFruits.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Kalimati Tarkari Price is not available for now',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    textDirection: TextDirection.ltr,
                    border: TableBorder.all(
                        color: Colors.black12,
                        width: 0.5,
                        style: BorderStyle.solid,
                        borderRadius: BorderRadius.circular(12)),
                    children: [
                      TableRow(
                        children: [
                          handleHeader('कृषि उपज'),
                          handleHeader('ईकाइ'),
                          handleHeader('न्यूनतम'),
                          handleHeader('अधिकतम'),
                          handleHeader('औसत'),
                        ],
                      ),
                      ...state.vegAndFruits.asMap().entries.map((entry) {
                        final e = entry.value;
                        final index = entry.key;

                        return TableRow(
                          decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Colors.green[300]
                                : Colors.green[200],
                          ),
                          children: [
                            handleValue(e.name),
                            handleValue(e.unit),
                            handleValue(e.minPrice),
                            handleValue(e.maxPrice),
                            handleValue(e.avgPrice),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
