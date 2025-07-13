// lib/views/eo/widgets/event_list_body.dart
import 'package:event_ease/data/model/auth/loginResponse.dart';
import 'package:event_ease/views/Eo/components/EventCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_ease/presentation/events/bloc/event_bloc.dart';

class BodyDashboard extends StatelessWidget {
  const BodyDashboard({super.key, required Data user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventLoadSuccess) {
          final events = state.events;
          if (events.isEmpty) {
            return const Center(child: Text('Belum ada event'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final e = events[index];
              return EventCard(event: e);  // <-- gunakan EventCard
            },
          );
        } else if (state is EventFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
