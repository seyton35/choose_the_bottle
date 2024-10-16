import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guess_the_bottle/domain/main_navigation/main_navigation.dart';
import 'package:guess_the_bottle/features/classic_game/classic_game_model.dart';
import 'package:provider/provider.dart';

class ClassicGame extends StatelessWidget {
  const ClassicGame({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => ClassicGameModel(),
      child: const ClassicGame(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classic'),
        leading: IconButton(
          onPressed: () => context.goNamed(MainNavigationRouteNames.mainMenu),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Field(),
    );
  }
}

class Field extends StatelessWidget {
  const Field({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    final dragColorsList = context.watch<ClassicGameModel>().dragColorsList;
    for (var i = 0; i < dragColorsList.length; i++) {
      final element = dragColorsList[i];
      children.add(BottleDraggable(
        color: element,
        index: i,
      ));
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const GamePanel(),
          Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.width,
            // width: MediaQuery.of(context).size.width,
            child: GridView.count(
              padding: const EdgeInsets.all(10),
              crossAxisCount: 3,
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class GamePanel extends StatelessWidget {
  const GamePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ClassicGameModel>();
    final colorsMatchingCount = model.colorsMatchingCount;
    final score = model.score;
    const textStyle = TextStyle(fontSize: 18);
    const titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => model.restart(),
          icon: const Icon(
            Icons.refresh,
            size: 35,
          ),
        ),
        const Text(
          'bottles match:',
          style: textStyle,
        ),
        Text(
          colorsMatchingCount.toString(),
          style: titleStyle,
        ),
        const Text(
          'score:',
          style: textStyle,
        ),
        Text(
          score.toString(),
          style: titleStyle,
        ),
        IconButton(
          onPressed: () => model.onPinTap(),
          icon: const Icon(
            Icons.push_pin,
            size: 35,
          ),
        )
      ],
    );
  }
}

class BottleDraggable extends StatelessWidget {
  const BottleDraggable({
    super.key,
    required this.color,
    required this.index,
  });
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ClassicGameModel>();
    final isFocusedBottle = model.focusedBottle;
    final isPinedBottle = model.pinedBottlesList[index];

    return Draggable(
      data: index,
      childWhenDragging: const Bottle(color: Colors.grey),
      feedback: Bottle(color: color),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isFocusedBottle == index)
            const Icon(Icons.lens, color: Colors.grey, size: 70),
          DragTarget<int>(
            onAccept: (dragIndex) =>
                context.read<ClassicGameModel>().onDragTargetDrop(
                      newIndex: dragIndex,
                      oldIndex: index,
                    ),
            builder: (context, candidateData, rejectedData) => InkWell(
              onTap: () => context.read<ClassicGameModel>().onBottleTap(index),
              child: Bottle(color: color),
            ),
          ),
          if (isPinedBottle)
            IconButton(
              icon: const Icon(
                Icons.lock_outline_sharp,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () => model.onBottleTap(index),
            ),
        ],
      ),
    );
  }
}

class Bottle extends StatelessWidget {
  const Bottle({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(
        Icons.lens_sharp,
        color: color,
        size: 55,
      ),
    );
  }
}
