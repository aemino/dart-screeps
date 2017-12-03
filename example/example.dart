import 'package:screeps/screeps.dart';

void main() {
  final creep = Game.creeps['bob'];
  if (creep.inventory.resourcePercent(Resource.energy) < 1) {
    final sources = creep.room.find(Find.sources);
    final source = creep.pos.findClosestObject(sources);

    try {
      creep.harvest(source);
    } on NotInRangeException {
      creep.moveTo(source.pos);
    }
  } else {
    final spawns = creep.room.find(Find.mySpawns);
    final spawn = creep.pos.findClosestObject(spawns);

    try {
      creep.transfer(spawn, Resource.energy);
    } on NotInRangeException {
      creep.moveTo(spawn.pos);
    }
  }
}
