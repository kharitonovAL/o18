import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/cubits/counter_cubit/counter_cubit.dart';
import 'package:o18_client/ui/counters/add_readings_page.dart';
import 'package:o18_client/ui/counters/charts_page.dart';

class CountersPage extends StatefulWidget {
  @override
  _CountersPage createState() => _CountersPage();
}

class _CountersPage extends State<CountersPage> {
  List<Counter> counterList = [];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toLocal();
    const startDay = 19;
    const endDay = 22;

    // todo: if there is need, we can show button only between 19 and 22 day on month

    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddRequestPage,
        label: const Text('Подать показания'),
      ),
    );

    //   floatingActionButton: today.day >= startDay && today.day <= endDay ? FloatingActionButton.extended(
    //   onPressed: () => _navigateToAddRequestPage(),
    //   label: Text('Подать показания'),
    // ) : Text('Передача показаний возможна с 19 по 22 число месяца'),
  }

  Widget _buildBody(
    BuildContext context,
  ) =>
      BlocBuilder<CounterCubit, CounterState>(
        builder: (
          context,
          state,
        ) {
          if (state is CounterLoading) {
            return const LinearProgressIndicator();
          } else if (state is CounterLoaded) {
            if (state.counterList.isEmpty) {
              return const Center(child: Text('Нет счетсчиков...'));
            }
            counterList = state.counterList;

            return ListView.builder(
              itemCount: state.counterList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                counter: state.counterList[index],
              ),
            );
          } else if (state is CounterLoadFailure) {
            return Center(
              child: Text('Ошибка: ${state.error}'),
            );
          } else if (state is CounterReadingsAdded) {
            counterList = state.counterList;
            return ListView.builder(
              itemCount: state.counterList.length,
              itemBuilder: (context, index) => _buildListItem(
                context: context,
                counter: state.counterList[index],
              ),
            );
          }

          return const Center(child: Text('Нет счетсчиков...'));
        },
      );

  Widget _buildListItem({
    required BuildContext context,
    required Counter counter,
  }) =>
      Card(
        child: ListTile(
          title: _isElectrincCounter(counter: counter)
              ? const Text('Электроснабжение (день)')
              : Text(counter.serviceTitle!),
          subtitle: _isElectrincCounter(counter: counter) ? const Text('Электроснабжение (ночь)') : null,
          trailing: _isElectrincCounter(counter: counter)
              ? Text(
                  '${counter.dayReadingList!.last.toString()}\n'
                  '${counter.nightReadingList!.last.toString()}',
                )
              : Text(
                  counter.dayReadingList!.last.toString(),
                ),
          onTap: () => Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => ChartsPage(counter: counter),
            ),
          ),
        ),
      );

  void _navigateToAddRequestPage() async => await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (context) => AddReadingsPage(counterList: counterList),
        ),
      ).then((value) {
        final accRepo = context.read<CounterCubit>().accountRepository;
        final counterRepo = context.read<CounterCubit>().counterRepository;
        final flatRepo = context.read<CounterCubit>().flatRepository;
        final ownerRepo = context.read<CounterCubit>().ownerRepository;
        final authRepo = context.read<CounterCubit>().authRepo;

        context.read<CounterCubit>().loadCounterList(
              authRepo: authRepo,
              ownerRepository: ownerRepo,
              flatRepository: flatRepo,
              accountRepository: accRepo,
              counterRepository: counterRepo,
            );
      });

  bool _isElectrincCounter({
    required Counter counter,
  }) =>
      counter.serviceTitle! == 'Электроснабжение';
}
