import 'package:event_ease/presentation/review/bloc/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewPage extends StatefulWidget {
  final int eventId;

  const ReviewPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewBloc>().add(
      FetchReviewRequested(widget.eventId.toString()),
    );
  }

  void _onDeleteReview(int reviewId) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Delete Review'),
            content: const Text('Are you sure you want to delete this review?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  context.read<ReviewBloc>().add(
                    DeleteReviewRequest(
                      reviewId: reviewId,
                      eventId: widget.eventId,
                    ),
                  );
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewLoadSuccess) {
            if (state.review.isEmpty) {
              return const Center(child: Text('No reviews available'));
            }
            return ListView.separated(
              itemCount: state.review.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final review = state.review[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(review.userId.toString())),
                  title: Text('Rating: ${review.rating.toString()}'),
                  subtitle: Text(review.comment ?? '-'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _onDeleteReview(review.id!),
                  ),
                );
              },
            );
          } else if (state is ReviewFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
