import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_app/controller/bookmark_manager.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/views/video_player_view.dart';

class DetialViewExample extends StatelessWidget {
  DetialViewExample({Key? key, required this.recipeModel}) : super(key: key);

  final RecipeModel recipeModel;

  BookmarkManager bookmarkManager = BookmarkManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(
              recipeModel.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white12,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerView(videoUrl: recipeModel.video),
                        ),
                      );
                    },
                    icon: Icon(Icons.play_arrow),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    iconSize: 60,
                  ),
                  radius: 40,
                ),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
                  elevation: 0,
                  margin: const EdgeInsets.all(24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: Container(
                            width: 60,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(90)),
                          ),
                        ),
                        Text(
                          recipeModel.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              recipeModel.category,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${recipeModel.rate}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(.6),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Ingredent ingredent =
                                        recipeModel.ingredents[index];
                                    return Row(
                                      children: [
                                        Text(
                                          ingredent.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          ingredent.quantity,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(height: 7),
                                  itemCount: recipeModel.ingredents.length)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey.shade300)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        bookmarkManager.addToBookMarks(recipeModel);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.bookmark_border_outlined),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.grey.shade300))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
