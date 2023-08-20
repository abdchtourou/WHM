import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/General/controller/categories/show_categories_controller_general.dart';
import 'package:untitled3/Keeper/controller/categories/show_categories_controller.dart';
import 'package:untitled3/Keeper/core/constant/image_asset.dart';
import 'package:untitled3/Keeper/data/datasource/remote/categroies/add_categories_data.dart';

import '../../../Keeper/core/constant/app_color.dart';
import '../../../Keeper/data/model/categories/add_categories_model.dart';
import '../../data/remote/categroies/add_categories_general_data.dart';



class AddCategoriesControllerGeneral extends GetxController {
  late TextEditingController categoryName;

  bool isDone = false;
  GlobalKey<FormState> formState = GlobalKey();
  AddCategoriesDataGeneral addCategoriesData = AddCategoriesDataGeneral(Get.find());
  ShowCategoriesControllerGeneral categoriesController =
      Get.put(ShowCategoriesControllerGeneral());

  postData() async {

    if(formState.currentState!.validate()){
      try {
        AddCategoriesModel add =
        AddCategoriesModel(categoryName: categoryName.text);

        var response = await addCategoriesData.postData(add.toJson());

        update();
        print(response);
        print(
            's................................................................. before response post11111${response[1]} ');

        if (response[1] == 201)
        {
          print(response[1]);
          return Get.defaultDialog(
              titleStyle: const TextStyle(color: Colors.white),

              backgroundColor: AppColor.backGround,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [Image.asset(ImageAsset.trueIcon)],
                ),
              ),
              title: " Added successfully ",
              textCancel: "Done",
              onCancel: () {
                categoriesController.getData();
              });
        } else {
          return Get.defaultDialog(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [Text("Fail")],
                ),
              ),
              title: " fail",
              textCancel: "Done",
              onCancel: () {
                categoriesController.getData();
              });
        }
      } catch (e) {
        throw Exception(e);
      }
    }else{

    }
  }

  @override
  void onInit() {
    categoryName = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    categoryName.dispose();

    super.dispose();
  }
}
