import 'package:bookify/constants/appconfig.dart';
import 'package:bookify/constants/color.dart';
import 'package:bookify/data/models/user.dart';
import 'package:bookify/presentation/screens/home/tabs/widgets/resuturants.dart';
import 'package:bookify/presentation/screens/search/bloc/search_bloc.dart';
import 'package:bookify/presentation/widgets/bloc_widgets/load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final User user;
  const SearchPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String queryText = "";
    TextEditingController searchField = TextEditingController();
    // searchField.
    double widhth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget widgetBody = Container();
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInit) {
          widgetBody = textBody(context, 'Busca un restaurante', Icons.search);
        } else if (state is SearchEmpty) {
          widgetBody = textBody(
              context,
              'No se encontraron restaurantes, prueba con otra palabra.',
              Icons.error_outline);
        }
        if (state is SearchLoading) {
          widgetBody = SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: const LoadWidget());
        } else if (state is SearchError) {
          widgetBody = textBody(context, state.message, Icons.close);
        } else if (state is SearchLoad) {
          widgetBody = RestaurantesWidget(restaurantes: state.rest);
        }
        return Scaffold(
          backgroundColor: backgroundColor,
          body: CustomScrollView(slivers: [
            SliverAppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                collapsedHeight: isTab() ? height / 7 : widhth / 3,
                backgroundColor: Colors.white,
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: appgradient,
                  ),
                  width: widhth,
                  child: Stack(children: [
                    Positioned(
                      top: 0,
                      child: Image.asset(
                        "assets/images/reservation_topFrame.png",
                        width: widhth,
                        fit: BoxFit.cover,
                        color: frameColor.withOpacity(0.45),
                      ),
                    ),
                    Positioned(
                      child: SafeArea(
                        child: SizedBox(
                          width: widhth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Buscar restaurante",
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: 250,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextField(
                                      autofocus: true,
                                      // controller: searchField,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (searchStr) =>
                                          BlocProvider.of<SearchBloc>(context)
                                              .add(SearchLoadEvent(
                                                  searchStr: searchStr,
                                                  user: user)),
                                      onChanged: (value) {
                                        queryText = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Buscar restaurante",
                                        hintStyle: TextStyle(
                                          fontSize: 19,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(SearchLoadEvent(
                                                    searchStr: queryText,
                                                    user: user));
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Icon(
                                            Icons.search,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                      )))
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                )),
            SliverToBoxAdapter(child: widgetBody)
          ]),
        );
      },
    );
  }
}

Widget textBody(BuildContext context, String text, icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    height: MediaQuery.of(context).size.height / 1.5,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 100,
          color: Colors.orange.withOpacity(0.8),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17),
        )
      ],
    ),
  );
}
