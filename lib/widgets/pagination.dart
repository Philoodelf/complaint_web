import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';




class Pagination extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? selectedCategoryId;
  final String? searchQuery;
  final int noOfItems;

  const Pagination({
    super.key,
    this.fromDate,
    this.toDate,
    this.selectedCategoryId,
    this.searchQuery,
    required this.noOfItems,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<UserCubit>().fetchComplaints(
      fromDate: widget.fromDate,
      toDate: widget.toDate,
      typeComplaintId: widget.selectedCategoryId,
      search: widget.searchQuery,
      noOfItems: widget.noOfItems,
    );
  }

  void fetchDataForPage(int page) {
    context.read<UserCubit>().fetchComplaints(
      pageNo: page,
      fromDate: widget.fromDate,
      toDate: widget.toDate,
      typeComplaintId: widget.selectedCategoryId,
      search: widget.searchQuery,
      noOfItems: widget.noOfItems,
    );
    print("🔄 Fetching data for page $page from API");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(145, 31, 63, 220),
            ),
          );
        }
        // Default values
        int totalPages = 1;
        int currentPage = 1;

        if (state is UserLoaded) {
          totalPages = state.totalPages;
          currentPage = state.pageNo;
        }

        if (totalPages == 0) {
        return const Center(
          child: Text("No complaints found."),
        );
      }

        return NumberPaginator(
          numberPages: totalPages,
          initialPage: currentPage - 1,
          onPageChange: (int index) {
            final int selectedPage = index + 1;
            fetchDataForPage(selectedPage);
          },
          child: const SizedBox(
            height: 48,
            child: Row(
              children: [
                PrevButton(),
                Expanded(child: NumberContent()),
                NextButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
