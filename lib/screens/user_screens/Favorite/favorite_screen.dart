import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/item_layer.dart';
import 'package:project8/models/item_model.dart';
import 'package:project8/screens/user_screens/Favorite/bloc/favorite_bloc.dart';
import 'package:project8/widgets/cards/favorites_item_card.dart';
import 'package:project8/widgets/other/page_title.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageTitle(title: "Favorites"),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is ErrorState) {
                    return Text(state.msg);
                  }
                  if (state is SuccessState) {
                    final List<ItemModel> fav =
                        GetIt.I.get<ItemLayer>().favItems;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: fav.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            FavoritesCard(favItem: fav[index]),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
