  // favourties(){
  //       documentslist.sort((a, b) => b['time'].compareTo(a['time']));
  //            documentslist.sort((a, b) => b['date'].compareTo(a['date']));
  //               Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate(documentslist);
  //   return 
  //    id.isEmpty?
  //     Center(child: Container(
  //       color: Colors.white,
  //       child:const Center(child: Text("No Data")),)):
  //     Container(
  //       color: Colors.white,
  //       child: GridView.builder(
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
  //         itemCount: documentslist.length,
  //         itemBuilder: (context,index){
  //           String dates = groupedDocuments.keys.elementAt(index);
  //                     List<DocumentSnapshot> documentsForDates = groupedDocuments[dates]!;
  //                     final pros = documentslist[index];
  //         return StreamBuilder(
  //               stream: getSubCollectionDocuments4(pros["url"],),
  //                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //           if (!snapshot.hasData) {
  //             return const Center(child: CircularProgressIndicator());
  //           }
  //           List<DocumentSnapshot> documents = snapshot.data!.docs;
  //               documents.sort((a, b) => b['time'].compareTo(a['time']));
  //                            documents.sort((a, b) => b['date'].compareTo(a['date']));
  //                 Map<String, List<DocumentSnapshot>> groupedDocuments =Appconstants.groupDocumentsByDate(documents);
          
  //           return groupedDocuments.isEmpty?Center(
  //                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo8xgVLOj4yCFyA8WRnfGZlOR15Dcz0x_Ygg&s")): 
  //                  Expanded(
  //                    child: ListView.builder(
  //                     itemCount: groupedDocuments.length,
  //                     itemBuilder: (context, index) {
  //                       String date = groupedDocuments.keys.elementAt(index);
  //                       List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
  //                       return Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                             Appconstants.formatDate(date),
  //                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           GridView.builder(
  //                             shrinkWrap: true,
  //                             physics:const NeverScrollableScrollPhysics(),
  //                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                               crossAxisCount: 2,
  //                               crossAxisSpacing: 4.0,
  //                               mainAxisSpacing: 4.0,
  //                             ),
  //                             itemCount: documentsForDate.length,
  //                             itemBuilder: (context, index) {
  //                               final pro = documentsForDate[index];
  //                               return Padding(
  //                                 padding: const EdgeInsets.all(8.0),
                                
  //                                   child: InkWell(
  //                                   onLongPress: (){
  //                                     showModalBottomSheet(
  //                                  context: context,
  //                                  isScrollControlled: true,
  //                                  builder: (BuildContext context) {
  //                                    return SizedBox(
  //                                      height: 100, // Adjust the height as needed
  //                                      child: Column(
  //                                        crossAxisAlignment: CrossAxisAlignment.stretch,
  //                                        mainAxisAlignment: MainAxisAlignment.center,
  //                                        mainAxisSize: MainAxisSize.min,
  //                                        children: <Widget>[
  //                     ListTile(
  //                       leading:const Icon(Icons.delete),
  //                       title:const Text('Delete'),
  //                       onTap: (){
  //                                deleteImage(pro["time"]);
  //                                Navigator.pop(context);
  //                       },
  //                     ),
  //                     // Add more options as needed
  //                                        ],
  //                                      ),
  //                                    );
  //                                  },
  //                                );
  //                                   },
  //                                   child: InstaImageViewer(
  //                                     child: Container(
  //                                       color: Colors.grey,
  //                                       child:
  //                                    CachedNetworkImage( imageUrl: pro["Favorites"],
  //                                     placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
  //                                     errorWidget: (context, url, error) =>const Icon(Icons.error),
  //                                   )
                                 
  //                                     ),
  //                                   ),
  //                                 ),
                                  
  //                               );
  //                             },
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                                        ),
  //                  );
  //         },
  //             );
  //          }
  //       ),
  //     );
  // }