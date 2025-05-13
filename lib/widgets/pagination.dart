import 'package:complaint_web/cubit/usercubit.dart';
import 'package:complaint_web/cubit/userstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';





// class Pagination extends StatefulWidget {
//   const Pagination({super.key});

//   @override
//   State<Pagination> createState() => _PaginationState();
// }

// class _PaginationState extends State<Pagination> {
//   int currentPage = 1;  
//   int totalPages = 7;   
//   int noOfItems = 20; 
//   int totalItems=125;  
  
  

//    @override
//   void initState() {
//     super.initState();
//     fetchDataForPage(currentPage); // Initial load
//   }
  
//   void fetchDataForPage(int page) {
//      context.read<UserCubit>().fetchComplaints(
//           pageNo: page,
//           noOfItems: noOfItems,
//         );
//     print("Fetching data for page $page");
//   }

// // @override
// //   void initState() {
// //     super.initState();
// //     // Trigger the first page fetch — this could also come from a parent widget if needed
// //     context.read<UserCubit>().fetchComplaints(); // Use default pageNo & noOfItems from backend
// //   }
// //    void fetchDataForPage(int page) {
// //     context.read<UserCubit>().fetchComplaints(pageNo: page);
// //     print("🔄 Fetching data for page $page from API");
// //   }

//   @override
//   Widget build(BuildContext context) {
//   //   int displayedCurrentPage = currentPage;
//   // int displayedTotalPages = totalPages;
//   // int displayedNoOfItems = noOfItems;
//     return BlocBuilder<UserCubit, UserState>(
//       builder: (context, state) {
//         if (state is UserLoaded) {
//           currentPage = state.pageNo;
//           totalPages = state.totalPages;
//           noOfItems = state.noOfItems;
//           // final int totalPages = state.totalPages;
//           // final int currentPage = state.pageNo;
//         // displayedCurrentPage = state.pageNo;
//         // displayedTotalPages = state.totalPages;
//         // displayedNoOfItems = state.noOfItems;
//         }

//         return NumberPaginator(
//           numberPages: totalPages,// displayedTotalPages,
//           initialPage: currentPage - 1, //displayedCurrentPage,
//           onPageChange: (int index) {
//             int selectedPage = index + 1;
//             fetchDataForPage(selectedPage);
//           },
//           child: const SizedBox(
//             height: 48,
//             child: Row(
//               children: [
//                 PrevButton(),
//                 Expanded(child: NumberContent()),
//                 NextButton(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class Pagination extends StatefulWidget {
  const Pagination({super.key});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<UserCubit>().fetchComplaints();
  }

  void fetchDataForPage(int page) {
    context.read<UserCubit>().fetchComplaints(pageNo: page);
    print("🔄 Fetching data for page $page from API");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
         if (state is PostLoading) {
      return  Center(child: CircularProgressIndicator(color: Color.fromARGB(145, 31, 63, 220),));
    }
        // Default values
        int totalPages = 1;
        int currentPage = 1;

        if (state is UserLoaded) {
          totalPages = state.totalPages;
          currentPage = state.pageNo;
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

