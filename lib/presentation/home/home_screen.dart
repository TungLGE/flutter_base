import 'package:di_demo/di/di.dart';
import 'package:di_demo/presentation/home/home_cubit.dart';
import 'package:di_demo/presentation/home/widget/empty_widget.dart';
import 'package:di_demo/presentation/home/widget/search_bar_widget.dart';
import 'package:di_demo/presentation/home/widget/weather_widget.dart';
import 'package:di_demo/util/presentation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<HomeCubit>(create: (context) => getIt())],
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().getWeatherInHaNoi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: SearchBarWidget(
              onSearch: (query) {
                context.read<HomeCubit>().searchCity(query);
              },
            ),
          ),
          Expanded(
            child: Center(
              child: _buildContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;

    switch (homeState.state) {
      case DataState.init:
      case DataState.loading:
        return const CircularProgressIndicator();
      case DataState.success:
        return WeatherWidget(
          weather: homeState.weather!,
          city: homeState.city!,
        );
      case DataState.fail:
        return const EmptyWidget();
    }
  }
}
