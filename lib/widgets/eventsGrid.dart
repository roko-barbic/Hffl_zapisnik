import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';
import '../widgets/userItem.dart';

class EventsGrid extends StatelessWidget {
  const EventsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<EventsList>(context);
    final loadedEvents = eventsData.events;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedEvents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 100),
      itemBuilder: (context, index) => loadedEvents[index].writeCard(context),
    );
  }
}
