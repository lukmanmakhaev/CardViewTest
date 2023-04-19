//
//  CardViewModel.swift
//  CardViewTest
//
//  Created by Lukman Makhaev on 17.04.2023.
//

import Foundation
import SwiftUI


class CardViewModel: ObservableObject {
    
    @Published var cardsList: [CardView] = []
    @Published var cards = [Responce]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showErrorAlert = false
    @Published var stopFetching = false
    @Published var offset = 0
    
    var networkService = NetworkService()
    
    func getCardData() {
        self.isLoading = true
        networkService.takeCompanies(offset: offset) { result in
            switch result {
                
            case .success(let data):
                self.cards = data
                for (i, _) in data.enumerated() {
                    self.cardsList.append(CardView(companyName: data[i].mobileAppDashboard.companyName,
                                                   logoUrl: data[i].mobileAppDashboard.logo,
                                                   points: data[i].customerMarkParameters.mark,
                                                   levelName: data[i].customerMarkParameters.loyaltyLevel.name,
                                                   cashback: data[i].customerMarkParameters.loyaltyLevel.cashToMark,
                                                   cardBackgroundColor: data[i].mobileAppDashboard.cardBackgroundColor,
                                                   highlightTextColor: data[i].mobileAppDashboard.highlightTextColor,
                                                   textColor: data[i].mobileAppDashboard.textColor,
                                                   mainColor: data[i].mobileAppDashboard.mainColor,
                                                   accentColor: data[i].mobileAppDashboard.accentColor,
                                                   backgroundColor: data[i].mobileAppDashboard.backgroundColor))
                    
                }
                self.isLoading = false
                
            case .failure(let error):
                print(error.errorDescription)
                self.errorMessage = error.errorDescription
                self.showErrorAlert = true
                self.isLoading = false
            }
        }
    }
    
    func getMoreData(index: Int) {
        guard cards.isEmpty == false else {
            stopFetching = true
            return
        }
        if index == cardsList.count - 1 && stopFetching == false {
            offset = cardsList.count
            getCardData()
            //print(index)
        }
    }
    
}
