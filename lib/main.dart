import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/data/repository/authRepository.dart';
import 'package:event_ease/data/repository/eventRepository.dart';
import 'package:event_ease/data/repository/orderRepository.dart';
import 'package:event_ease/data/repository/profileRepository.dart';
import 'package:event_ease/presentation/auth/bloc/auth_bloc.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/presentation/profile/bloc/profile_bloc.dart';
import 'package:event_ease/services/service_http_client.dart';
import 'package:event_ease/views/loginPage.dart';
import 'package:event_ease/views/Eo/dashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final serviceHttpClient = ServiceHttpClient();
  runApp(MyApp(serviceHttpClient: serviceHttpClient));
}

class MyApp extends StatelessWidget {
  final ServiceHttpClient serviceHttpClient;
  const MyApp({super.key, required this.serviceHttpClient});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(
          authRepository: AuthRepository(serviceHttpClient))),
        BlocProvider(create: (_) => EventBloc(
          EventRepository(serviceHttpClient))),
        BlocProvider(create: (_) => ProfileBloc(
          ProfileRepository(serviceHttpClient))),
          BlocProvider(create: (_) => OrderBloc(
            OrderRepository(serviceHttpClient),
          ))
      ],
      child: MaterialApp(
        title: 'Event Ease',
        theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        initialRoute: '/login',
        routes: {
          '/login': (ctx) => const LoginPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/dashboard') {
            final args = settings.arguments;
            // Pastikan args adalah Data (user)
            if (args is Data) {
              return MaterialPageRoute(
                builder: (_) => DashboardPage(user: args),
              );
            }
            // Jika tidak ada user, bisa redirect ke login atau tampilkan error
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
            );
          }
          return null; // fallback ke routes biasa
        },
      ),
    );
  }
}
