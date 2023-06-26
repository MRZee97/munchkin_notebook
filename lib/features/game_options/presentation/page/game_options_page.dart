import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:munchkin/core/ui/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:munchkin/core/ui/widgets/secondary_button.dart';
import 'package:munchkin/features/base_page/presentation/base_page.dart';
import 'package:munchkin/features/game/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:munchkin/main.dart';
import 'package:munchkin/navigation/router.gr.dart';

@RoutePage()
class GameOptionPage extends StatelessWidget {
  const GameOptionPage({super.key});

  static const TextStyle textRendering = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.titleColor,
      fontFamily: "academy");

  static const screenMargins = EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: AppLocalizations.of(context)!.gameParameters,
        body: Padding(
          padding: screenMargins,
          child: Expanded(
            child: BlocBuilder<GameBloc, GameState>(
              bloc: gameBloc,
              builder: (context, state) {
                if (state is GameCreated) {
                  return Column(children: [
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gameCode,
                            style: textRendering,
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () =>
                          context.router.push(const MultiplayerRoute()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.numberPlayers,
                                style: textRendering,
                              ),
                              Text(
                                state.game.players.length.toString(),
                                style: textRendering,
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.level,
                                style: textRendering,
                              ),
                              Text(
                                state.game.maxLevel.toString(),
                                style: textRendering,
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.game.isAnarchy
                                ? AppLocalizations.of(context)!.independently
                                : AppLocalizations.of(context)!.gameMaster,
                            style: textRendering,
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ]);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
        actions: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            SecondaryButton(
                text: AppLocalizations.of(context)!.buttonReturnGame,
                onPressed: () {
                  context.router.pop();
                }),
            const SizedBox(height: 38),
          ],
        ));
  }
}
