import 'package:complaint_web/core/api/api_consumer.dart';
import 'package:complaint_web/core/api/endpoints.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:complaint_web/model/complaints_model.dart';
import 'package:complaint_web/model/pagination_model.dart';
import 'package:complaint_web/shared_preferences/storage_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> complaintStatuses = [];
  UserCubit(this.api) : super(UserInitial());
  GlobalKey<FormState> sendItFormKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> logIn(String userName, String password) async {
    try {
      emit(PostLoading());

      Map<String, dynamic> loginData = {
        "userName": userName,
        "password": password,
      };

      Response? response = await api.post(Endpoints.login, data: loginData);
      print("📦 Response: ${response?.data}");

      if (response != null &&
          response.statusCode == 200 &&
          response.data['result'] == true &&
          response.data['token'] != null) {
        print("✅ Login successfully!");
        emit(SendSuccess());

        String token = response.data["token"];
        api.setAuthToken(token);
        await TokenStorage.saveToken(token);

        await Future.delayed(const Duration(seconds: 2));
        emit(UserInitial());
      } else {
        String errorMsg = "Invalid username or password";

        if (response?.data['errors'] != null &&
            response!.data['errors'].isNotEmpty) {
          errorMsg = response.data['errors'][0]; // Arabic error from backend
        }

        print("⚠️ Login failed: $errorMsg");
        emit(SendFailure(errMessage: errorMsg));
      }
    } on Exception catch (e) {
      print("❌ Error posting complaint: $e");
      emit(SendFailure(errMessage: "An error occurred: $e"));
    }
  }

  List<Map<String, dynamic>> complaints = [];

  Future<void> fetchAllComplaintStatuses() async {
    try {
      emit(PostLoading()); // Optional: if you want loading state.

      Response? response = await api.get(Endpoints.statusComplaint);

      print("📦 Complaint Status Response: ${response?.data}");

      if (response != null &&
          response.statusCode == 200 &&
          response.data['data'] is List) {
        complaints = List<Map<String, dynamic>>.from(response.data['data']);
        emit(UserInitial());
      } else {
        emit(SendFailure(errMessage: "Failed to load complaints."));
      }
    } catch (e) {
      print("❌ Error fetching complaints: $e");
      emit(SendFailure(errMessage: "Error fetching complaints."));
    }
  }
  //   Future<void> fetchAllComplaintStatuses() async {
  //   try {
  //     emit(PostLoading());

  //     final response = await api.get(Endpoints.statusComplaint);

  //     print("📦 Complaint Status Response: ${response?.data}");

  //     if (response != null &&
  //         response.statusCode == 200 &&
  //         response.data['data'] is List) {
  //       complaintStatuses = List<Map<String, dynamic>>.from(response.data['data']);
  //       emit(StatusLoaded(complaintStatuses)); // create this state
  //     } else {
  //       emit(SendFailure(errMessage: "Failed to load complaints."));
  //     }
  //   } catch (e) {
  //     print("❌ Error fetching complaints: $e");
  //     emit(SendFailure(errMessage: "Error fetching complaints."));
  //   }
  // }

  Future<void> fetchCategories({String? typeComplaintId}) async {
    try {
      emit(PostLoading());

      final response = await api.get(
        Endpoints.categoryComplaint,
      ); // replace with actual endpoint

      // print("📦 Categories Response: ${response?.data}");

      if (response != null &&
          response.statusCode == 200 &&
          response.data["result"] == true &&
          response.data["data"] is List) {
        categories = List<Map<String, dynamic>>.from(response.data["data"]);
        emit(UserInitial()); // notify UI
      } else {
        emit(SendFailure(errMessage: "Failed to load categories."));
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      emit(SendFailure(errMessage: "Error fetching categories."));
    }
  }

  //

  // // get all complains
  Future<void> fetchComplaints({
    DateTime? fromDate,
    DateTime? toDate,
    String? typeComplaintId,
    int pageNo=1 , 
    int noOfItems=20, // Number of items per page ????
  }) async {
    emit(PostLoading());

    try {
      print(
        "📅 Filtering from: $fromDate to: $toDate 🏷️ Category: $typeComplaintId",
      );

      final queryParams = <String, dynamic>{};

      if (fromDate != null) {
        queryParams['fromDate'] =
            fromDate.toIso8601String().split('T')[0]; // YYYY-MM-DD
      }

      if (toDate != null) {
        queryParams['toDate'] = toDate.toIso8601String().split('T')[0];
      }

      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'userId': "d03a0db5-6208-4a27-a1be-1f9aa4c3cc26",
        'PageNo': pageNo.toString(), // Pagination page number
        'NoOfItems': noOfItems.toString(), // Number of items per page
        if (typeComplaintId != null && typeComplaintId.isNotEmpty)
          'TypecomplaintId': typeComplaintId,
      };

      print("📡 Sending headers: $headers");
      print("📡 Sending query params: $queryParams");

      final response = await api.get(
        Endpoints.allComplaints,
        queryParameters: queryParams,
        headers: headers,
      );
      print("📡 Response status code: ${response.statusCode}");

      //  print("📡 Response body: ${response.data}");

      if (response.statusCode == 200 && response.data['result'] == true) {
        final List<dynamic> jsonList = response.data['data'] ?? [];

        if (jsonList == null) {
          print("❗ API returned null for 'data'");
          emit(UserError("API returned null for complaints list."));
          return;
        }

        print("📦 Total complaints received: ${jsonList.length}");

        

        final complaints =
            jsonList
                .map((item) {
                  try {
                    final complaintDateStr = item["date"];
                    if (complaintDateStr == null) {
                      print("⚠️ Skipping item with no date: $item");
                      return null;
                    }

                    final complaintDate = DateTime.parse(complaintDateStr);
                    print("🗓️ Complaint Date: $complaintDate");

                    bool isWithinRange = true;

                    if (fromDate != null && complaintDate.isBefore(fromDate)) {
                      isWithinRange = false;
                    }

                    if (toDate != null && complaintDate.isAfter(toDate)) {
                      isWithinRange = false;
                    }

                    if (isWithinRange) {
                      return Complaint.fromJson(item as Map<String, dynamic>);
                    } else {
                      print("⛔ Outside date range: $complaintDate");
                      return null;
                    }
                  } catch (e) {
                    print("❌ Error parsing item: $item");
                    print("   ↪️ Reason: $e");
                    return null;
                  }
                })
                .whereType<Complaint>()
                .toList(); // Removes nulls safely

        print("✅ Complaints after filtering: ${complaints.length}");
        final int totalItems =
            response.data['totalItems'] ??
            0; // Extract totalItems from the response
        final int noOfItems =
            response.data['noOfItems'] ?? 0; // Extract noOfItems per page
        final int totalPages =
            (totalItems / noOfItems).ceil(); // Calculate totalPages
        final int pageNo= response.data['pageNo'] ?? 1;

        print('Total Items: $totalItems');
        print('Total Pages: $totalPages');

        emit(UserLoaded(complaints, totalPages, pageNo, noOfItems, totalItems));
        print("✅ Loaded complaints count: ${complaints.length}");
      } else {
        emit(UserError("Failed to load complaints: Invalid response"));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("🔴 Dio error response data: ${e.response?.data}");
        print("🔴 Dio error status code: ${e.response?.statusCode}");
      } else {
        print("🔴 Dio error without response: ${e.message}");
      }
      emit(UserError("Dio error: ${e.message}"));
    } catch (e) {
      emit(UserError("Unexpected error: ${e.toString()}"));
      print("unexpected ");
    }
  }

  List<Complaint> filteredComplaints = [];
  List<Complaint> allComplaints = [];
  //  void filterComplaintsBySearch(String query) {
  //   print("🔍 Filtering complaints with query: $query");
  //   final input = query.toLowerCase();
  //   filteredComplaints = allComplaints.where((complaint) {
  //     final content = complaint.content?.toLowerCase() ?? '';
  //     final description = complaint.description?.toLowerCase() ?? '';
  //     final serial = complaint.serialNo?.toLowerCase() ?? '';
  //     final matches = content.contains(input) ||
  //         description.contains(input) ||
  //         serial.contains(input);
  //     print("   Matches: $matches - Content: $content, Description: $description, Serial: $serial");
  //     return matches;
  //   }).toList();

  //   emit(UserLoaded(filteredComplaints));
  //   print("✅ Complaints after filtering: ${filteredComplaints.length}");
  // }
}
