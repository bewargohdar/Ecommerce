import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecomerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ages extends StatelessWidget {
  const Ages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.7,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AgesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AgesLoaded) {
            return _ages(state.ages);
          }

          if (state is AgesLoadFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox(); // Fallback case
        },
      ),
    );
  }

  Widget _ages(List<QueryDocumentSnapshot<Map<String, dynamic>>> ages) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: ages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context
                .read<AuthBloc>()
                .add(SelectAge(ages[index].data()['value']));
          },
          child: Text(
            ages[index].data()['value'],
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}
