import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/screens/user_screens/page_bloc/page_bloc.dart';

class UserNavigation extends StatelessWidget {
  const UserNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<PageBloc>();
        bloc.add(ChangePageEvent(index: bloc.currentPage));
        return DefaultTabController(
          length: 5,
          child: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              if(state is ShowState) {
                return BottomBar(
                  barColor: AppConstants.mainBlue,
                  width: context.getWidth(divideBy: 1.15),
                  borderRadius: BorderRadius.circular(15),
                  // hideOnScroll: false,
                  body: (context, controller)=> bloc.pages[bloc.currentPage],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TabBar(
                      onTap: (value) => bloc.add(ChangePageEvent(index: value)),
                      isScrollable: false,
                      physics: const ScrollPhysics(),
                      indicatorColor: Colors.transparent,
                      labelColor: AppConstants.mainWhite,
                      unselectedLabelColor: AppConstants.unselectedColor,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        // to be modified later << NOTICE >>
                        FaIcon(FontAwesomeIcons.house),
                        FaIcon(FontAwesomeIcons.cartShopping),
                        FaIcon(FontAwesomeIcons.heart),
                        FaIcon(FontAwesomeIcons.list),
                        Icon(Icons.person),
                      ]
                    ),
                  )
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        );
      }),
    );
  }
}