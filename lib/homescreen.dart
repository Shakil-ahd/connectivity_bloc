import 'package:connectivity_bloc/bloc/internet_bloc.dart';
import 'package:connectivity_bloc/bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connectivity Status")),
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Internet Connected ✅"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Internet Lost ❌"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Center(
          child: BlocBuilder<InternetBloc, InternetState>(
            builder: (context, state) {
              if (state is InternetConnectedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.wifi, color: Colors.green, size: 80),
                    SizedBox(height: 10),
                    Text(
                      "Connected 🌐",
                      style: TextStyle(fontSize: 22, color: Colors.green),
                    ),
                  ],
                );
              } else if (state is InternetLostState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.wifi_off, color: Colors.red, size: 80),
                    SizedBox(height: 10),
                    Text(
                      "Disconnected 🚫",
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  ],
                );
              }

              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Checking connection..."),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
