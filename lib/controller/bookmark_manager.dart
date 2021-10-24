import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_service.dart';

class BookmarkManager with ChangeNotifier {
  BookmarkManager();

  BookmarkService bookmarkService = BookmarkService();

  Future<List<RecipeModel>?> getAllBookMarks() async {
    try {
      await bookmarkService.open();
      List<RecipeModel>? recipies = await bookmarkService.getAllRecipe();
      notifyListeners();
      return recipies;
    } catch (error) {
      print("Something went wrong fetching recipies $error");
      // throw ErrorDescription("Failed to fetch recipies... Please try again");
      throw error;
    }
    //  finally {
    //   await bookmarkService.close();
    // }
  }

  Future<bool> isBookmarked(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      RecipeModel? recipies = await bookmarkService.getRecipe(recipeModel.id!);
      notifyListeners();
      return recipies != null;
    } catch (error) {
      print("Something went wrong checking isBookmarked recipe $error");
      throw error;
    }
    //  finally {
    //   await bookmarkService.close();
    // }
  }

  Future<RecipeModel?> addToBookMarks(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      RecipeModel recipe = await bookmarkService.insert(recipeModel);
      print('Added to boomarks: ${recipe.toJson()}');
      await getAllBookMarks();
      toast(msg: "Added to bookmarks");
      return recipe;
    } catch (error) {
      print("Something went wrong adding recipies $error");
      return null;
    }
    //  finally {
    //   await bookmarkService.close();
    // }
  }

  void toast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<int> removeFromBookmarks(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      int deleteCount = await bookmarkService.delete(recipeModel.id!);
      print('Deleted $deleteCount recipies from boomarks');
      await getAllBookMarks();
      toast(msg: "Removed from bookmarks");
      return deleteCount;
    } catch (error) {
      print("Something went wrong adding recipies $error");
      return 0;
    }
    //  finally {
    //   await bookmarkService.close();
    // }
  }
}
