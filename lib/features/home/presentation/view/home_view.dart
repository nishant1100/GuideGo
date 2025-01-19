import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            gradient: LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              // Logout code
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
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.place),
                label: 'Place',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rocket_launch_sharp),
                label: 'About Us',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 6, 68, 202),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            elevation: 10.0,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add functionality here, e.g., navigate to a new screen or trigger a key action
      //     showMySnackBar(
      //       context: context,
      //       message: 'Quick action triggered!',
      //       colorr: const Color(0xFF2196F3),
      //     );
      //   },
      //   backgroundColor: Colors.teal,
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
    );
  }
}
