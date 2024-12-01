import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_blight/screen/features/news/bloc/news_bloc.dart';
import 'package:late_blight/screen/features/news/widgets/render_news.dart';
import 'package:late_blight/utils/enums.dart';

class AgricultureNews extends StatefulWidget {
  const AgricultureNews({super.key});

  @override
  State<AgricultureNews> createState() => _AgricultureNewsState();
}

class _AgricultureNewsState extends State<AgricultureNews> {
  final selectedSource = ValueNotifier('All');
  final scrollController = ScrollController();
  final sources = {
    'All': 'All',
    'AITC': 'aitc.gov.np',
    'Gorkha Patra Online': 'gorkhapatraonline.com',
    'Halo Khabar': 'halokhabar.com',
    'VCDC': 'vcdc.gov.np',
    'DOA Nepal': 'doanepal.gov.np',
  };
  @override
  void initState() {
    super.initState();
    final bloc = context.read<NewsBloc>();
    bloc.setPage(1);
    bloc.getNews(source: 'All');
    scrollController.addListener(handleScroll);
  }

  void handleScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      final bloc = context.read<NewsBloc>();
      if (!bloc.state.reachedLimit) {
        bloc.getNews(
          source: sources[selectedSource.value] ?? "All",
          getMore: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      final bloc = context.read<NewsBloc>();
      bloc.setPage(1);
      return Future.delayed(const Duration(seconds: 1), () {
        bloc.getNews(source: sources[selectedSource.value] ?? "All");
      });
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<NewsBloc, News>(builder: (context, state) {
          if (state.requestState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.requestState == RequestState.fail) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return CustomScrollView(
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      for (final source in sources.keys)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ValueListenableBuilder(
                              valueListenable: selectedSource,
                              builder: (context, value, child) {
                                return Material(
                                  color: source == value
                                      ? Colors.grey[800]
                                      : Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      selectedSource.value = source;
                                      final bloc = context.read<NewsBloc>();
                                      bloc.setPage(1);
                                      bloc.getNews(
                                        source: sources[source] ?? "All",
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        source,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ]),
                  ),
                ),
                RenderLatestNews(newsList: state.latest),
                RenderNews(newsList: state.newsList),
              ],
            );
          }
        }),
      ),
    );
  }
}
