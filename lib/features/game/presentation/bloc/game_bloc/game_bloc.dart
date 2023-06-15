import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munchkin/features/game/domain/entities/game.dart';
import 'package:munchkin/features/game/domain/entities/player.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Game? _game;
  List<Player> _players = [];

  GameBloc() : super(GameNotReady()) {
    on<GameEvent>((event, emit) {
      if (event is CreateGame) {
        _players = event.players;
        _game = Game(
            maxLevel: event.maxLevel,
            isAnarchy: event.isAnarchy,
            players: event.players);
        emit(GameCreated(_game!));
      }
      if (event is ChangeGameMaxLevel) {
        if (_game != null) {
          _game = _game!.copyWith(maxLevel: event.maxLevel);
          emit(GameCreated(_game!));
        }
      }
      if (event is AddPlayer) {
        if (_game != null) {
          _players.add(event.player);
          _game = _game!.copyWith(players: _players);
          emit(GameCreated(_game!));
        }
      }
    });
  }
}
