import 'package:fit_beat/app/common_widgets/custom_app_bar.dart';
import 'package:fit_beat/app/common_widgets/custom_text.dart';
import 'package:fit_beat/app/common_widgets/custom_text_field.dart';
import 'package:fit_beat/app/data/model/user/block_user_model.dart';
import 'package:fit_beat/app/data/provider/api.dart';
import 'package:fit_beat/app/data/repository/api_repository.dart';
import 'package:fit_beat/app/features/blockUnblockUser/controllers/block_unblock_user_controller.dart';
import 'package:fit_beat/app/features/blockUnblockUser/view/block_user_row.dart';
import 'package:fit_beat/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Blocked Users",
      ),
      body: GetBuilder<BlockUnBlockController>(
          init: BlockUnBlockController(
              repository: ApiRepository(apiClient: ApiClient())),
          builder: (_) {
            return _.isBlockUserListLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: CustomTextField(
                            hintText: "Search People",
                            height: 36,
                            prefixIcon: Icon(
                              Icons.search,
                              color: FF025074,
                            ),
                            hintColor: hintColor,
                            isPaddingRequired: false,
                            inputType: TextInputType.text,
                            showIcon: true,
                            endIcon: Icons.close,
                            bgColor: FFE0EAEE,
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          child: _.userBlockList.length > 0
                              ? ListView.separated(
                                  itemCount: _.userBlockList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    BlockUser blockUser =
                                        _.userBlockList[index];

                                    return BlockUserRow(
                                      blockUser: blockUser,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      thickness: 0.4,
                                      color: dividerColor,
                                    );
                                  },
                                )
                              : Container(
                                  child: Center(
                                      child: CustomText(
                                    text: "No Block User Found",
                                    color: FF050707,
                                    size: 16,
                                  )),
                                ),
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
