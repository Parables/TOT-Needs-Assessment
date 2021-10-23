import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_service.dart';

class BookmarkManager with ChangeNotifier {
  BookmarkManager();

  BookmarkService bookmarkService = BookmarkService();

  Future<List<RecipeModel>> getAllBookMarks() async {
    try {
      await bookmarkService.open();
      List<RecipeModel>? recipies = await bookmarkService.getAllRecipe();
      if (recipies != null) {
        print(
            'Fetching a bookmarked recipies ${recipies.length} => ${jsonEncode(recipies)}');
        notifyListeners();
        return recipies;
      }
      return [];
    } catch (error) {
      print("Something went wrong fetching recipies $error");
      return [];
    } finally {
      await bookmarkService.close();
    }
  }

  addToBookMarks(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      RecipeModel recipe = await bookmarkService.insert(recipeModel);
      print('Added to boomarks: ${recipe.toJson()}');
      await getAllBookMarks();
    } catch (error) {
      print("Something went wrong adding recipies $error");
    } finally {
      await bookmarkService.close();
    }
  }

  removeFromBookmarks(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      int deleteCount = await bookmarkService.delete(recipeModel.id!);
      print('Deleted $deleteCount recipies from boomarks');
      await getAllBookMarks();
    } catch (error) {
      print("Something went wrong adding recipies $error");
    } finally {
      await bookmarkService.close();
    }
  }
}
