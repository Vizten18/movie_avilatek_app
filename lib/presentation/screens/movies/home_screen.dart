import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_avilatek_app/presentation/providers/movies/initial_loading.dart';
import 'package:movie_avilatek_app/presentation/widgets/widgets.dart';
import 'package:movie_avilatek_app/presentation/providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    if (initialLoading) return const ScreenLoader();

    final popularMovies = ref.watch(popularMoviesProvider);

    return Visibility(
      visible: !initialLoading,
      child: SafeArea(
        child: Material(
          child: Scaffold(
            key: widget._scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Lastest',
                style: TextStyle(
                  fontFamily: 'BalooBold',
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                ),
              ),
              toolbarHeight: 100,
              leading: IconButtonWidget(
                icon: Icons.menu,
                onPressed: () {
                  widget._scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
            drawer: DrawerMenu(scaffoldKey: scaffoldKey),
            body: Column(
              children: [
                Expanded(
                  child: MovieMasonry(
                    movies: popularMovies,
                    loadNextPage: () =>
                        ref.read(popularMoviesProvider.notifier).loadNextPage(),
                    crossAcountLandscape: 4,
                    crossAcountVertical: 2,
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
