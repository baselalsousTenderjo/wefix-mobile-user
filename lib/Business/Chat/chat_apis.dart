import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wefix/Business/end_points.dart';
import 'package:wefix/Data/Api/http_request.dart';
import 'package:wefix/Data/model/chats_model.dart';

class ChatApis {
  static Future sendMessages({
    int? toUserId,
    int? ticketId,
    String? message,
    String? image,
    BuildContext? context,
    String? token,
  }) async {
    try {
      final response = await HttpHelper.postData(
        query: EndPoints.chat,
        token: token,
        data: {
          "ToUserId": toUserId ?? 0,
          "TicketId": ticketId,
          "message": message ?? "",
          "image": image
        },
      );

      log('sendMessage() [ STATUS ] -> ${response.statusCode}');

      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        return body;
      } else {
        return null;
      }
    } catch (e) {
      log('sendMessage() [ ERROR ] -> $e');
      return null;
    }
  }

  static ChatsModel? chatsModel;
  static List? chatsList;
  static Future getMessages({String? token, id}) async {
    try {
      final response = await HttpHelper.getData(
        query: EndPoints.messages + id,
        token: token,
      ).timeout(const Duration(seconds: 10)); // Increased timeout

      log('getMessages() [ STATUS ] -> ${response.statusCode}');

      final body = json.decode(response.body);

      if (response.statusCode == 200) {
        return body['chats'];
      } else {
        return null;
      }
    } on TimeoutException catch (e) {
      log('getMessages() [ TIMEOUT ] -> $e');
      return null;
    } catch (e) {
      log('getMessages() [ ERROR ] -> $e');
      return null;
    }
  }
}
