import 'package:di_demo/data/city_repo.dart';
import 'package:di_demo/data/weather_repo.dart';
import 'package:di_demo/presentation/home/home_cubit.dart';
import 'package:di_demo/presentation/home/widget/empty_widget.dart';
import 'package:di_demo/presentation/home/widget/weather_widget.dart';
import 'package:di_demo/util/presentation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(
            context.read<WeatherRepo>(),
            context.read<CityRepo>()
          ),
        )
      ],
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
      body: Center(
        child: _buildContent(context),
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
        return WeatherWidget(weather: homeState.weather!);
      case DataState.fail:
        return const EmptyWidget();
    }
  }
}
