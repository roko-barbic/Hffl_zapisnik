import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/cubit/auth_cubit.dart';
import 'package:hffl_zapisnik/screens/clubs_ranking_screen.dart';
import 'package:hffl_zapisnik/screens/tournaments_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.redAccent,
        title: const Padding(
          padding: EdgeInsets.only(left: 42.0),
          child: Center(
            child: Text(
              "Extrapoint",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  context.read<AuthCubit>().logout();
                },
              );
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          controller: _tabController,
          tabs: const [
            Tab(
                icon: Text(
              "Poredak",
              style: TextStyle(fontSize: 16),
            )),
            Tab(
                icon: Text(
              "Turniri",
              style: TextStyle(fontSize: 16),
            )),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ClubsRanking(),
          TournamentsScreen(),
        ],
      ),
    );
  }
}
