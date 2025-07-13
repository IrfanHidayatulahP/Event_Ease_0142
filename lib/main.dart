import 'package:event_ease/data/repository/authRepository.dart';
import 'package:event_ease/data/repository/eventRepository.dart';
import 'package:event_ease/data/repository/orderRepository.dart';
import 'package:event_ease/data/repository/profileRepository.dart';
import 'package:event_ease/data/repository/reviewRepository.dart';
import 'package:event_ease/data/repository/ticketRepository.dart';
import 'package:event_ease/presentation/auth/bloc/auth_bloc.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';
import 'package:event_ease/presentation/order/bloc/order_bloc.dart';
import 'package:event_ease/presentation/profile/bloc/profile_bloc.dart';
import 'package:event_ease/presentation/review/bloc/review_bloc.dart';
import 'package:event_ease/presentation/ticket/bloc/ticket_bloc.dart';
import 'package:event_ease/services/service_http_client.dart';
import 'package:event_ease/views/loginPage.dart';
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
        BlocProvider(
          create:
              (_) =>
                  AuthBloc(authRepository: AuthRepository(serviceHttpClient)),
        ),
        BlocProvider(
          create: (_) => EventBloc(EventRepository(serviceHttpClient)),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(ProfileRepository(serviceHttpClient)),
        ),
        BlocProvider(
          create: (_) => OrderBloc(OrderRepository(serviceHttpClient)),
        ),
        BlocProvider(
          create: (_) => TicketBloc(TicketRepository(serviceHttpClient)),
        ),
        BlocProvider(
          create: (_) => ReviewBloc(ReviewRepository(serviceHttpClient)),
        ),
      ],
      child: MaterialApp(
        title: 'Event Ease',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}
