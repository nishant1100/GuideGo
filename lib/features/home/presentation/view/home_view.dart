import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
import 'package:guide_go/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              color:Color(0xFF9C27B0),
          ),
        ),
        title: const Text(
          'GUIDE GO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging Out.',
                color: Colors.red,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.views.elementAt(state.selectedIndex),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.blueAccent,
            buttonBackgroundColor: Colors.white,
            height: 60,
            animationDuration: const Duration(milliseconds: 300),
            index: state.selectedIndex,
            items: const [
              Icon(Icons.home, size: 30, color: Colors.black),
              Icon(Icons.place, size: 30, color: Colors.black),
              Icon(Icons.rocket_launch_sharp, size: 30, color: Colors.black),
              Icon(Icons.person, size: 30, color: Colors.black),
            ],
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}