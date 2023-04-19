//
//  ContentView.swift
//  CardViewTest
//
//  Created by Lukman Makhaev on 15.04.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @StateObject var viewModel = CardViewModel()
    @State var items = 0
    
    
    var body: some View {
        ZStack {
            Color(hex: "efefef")
                .edgesIgnoringSafeArea(.all)

            VStack (spacing: 0){
                Text ("Управление картами")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .font(.system(size: 23))
                    //.fontWeight(.medium)
                    .foregroundColor(Color(hex: "2688eb"))
                    
                
                ScrollView (showsIndicators: false) {
                    LazyVStack {
                        ForEach (0 ..< $viewModel.cardsList.count, id: \.self) { i in
                            viewModel.cardsList[i]
                                .onAppear() {
                                    viewModel.getMoreData(index: i)
                                }
                        }
                    }
                    .padding(.top)
                    if viewModel.isLoading {
                        ProgressView(label: {
                            Text ("Подгрузка компаний")
                        })
                            .padding()
                    }
                }
                .background(Color.clear)
                .padding(.horizontal)
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text(viewModel.errorMessage!),
                    dismissButton: .default(Text("OK")) {
                        viewModel.showErrorAlert = false
                    }
                )
            }
        }
        .task {
            await viewModel.getCardData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 14 Plus"))
                    .previewDisplayName("iPhone 14 Plus")

                ContentView()
                    .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
                    .previewDisplayName("iPhone 14 Pro Max")
    }
}


//List {
//    ForEach (0 ..< $viewModel.cardsList.count, id: \.self) { i in
//        viewModel.cardsList[i]
//            .onAppear() {
//                self.items += 1
//                print(items)
//                if (items == $viewModel.cardsList.count) {
//                    viewModel.isLoading = true
//                    viewModel.getCardData()
//                    //print($viewModel.cardsList.count)
//                }
//                print($viewModel.cardsList.count)
//            }
//    }
//    .listRowSeparator(.hidden)
//    .listRowBackground(Color(hex: "efefef"))
//
//    if viewModel.isLoading {
//        HStack (alignment: .center){
//            Spacer()
//            ProgressView()
//            Spacer()
//        }
//        .padding(.vertical)
//        .listRowSeparator(.hidden)
//        .listRowBackground(Color(hex: "efefef"))
//    }
//
//
//}
//.listStyle(PlainListStyle())
