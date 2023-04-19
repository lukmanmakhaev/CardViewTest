//
//  CardView.swift
//  CardViewTest
//
//  Created by Lukman Makhaev on 15.04.2023.
//

import Foundation
import SwiftUI
import Alamofire
import Kingfisher

struct CardView: View {
    
    var companyName: String
    var logoUrl: String
    var points: Int
    var levelName: String
    var cashback: Int
    
    var cardBackgroundColor: String
    var highlightTextColor: String
    var textColor: String
    var mainColor: String
    var accentColor: String
    var backgroundColor: String
    
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Text(companyName)
                    .font(.system(size: 25))
                    .foregroundColor(Color(hex: highlightTextColor))
                    .lineLimit(1)
                    .padding(.bottom, 7)
                
                Spacer()
                
                KFImage(URL(string: logoUrl))
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding(.bottom, 7)
            }
            
            Divider()
            
            HStack (alignment: .bottom){
                
                VStack {
                    Text(String(points))
                        .font(.system(size: 30))
                        .foregroundColor(Color(hex: highlightTextColor))
                        .fontWeight(.medium)
                    
                    
                    + Text(" баллов")
                        .foregroundColor(Color(hex: textColor))
                        .font(.system(size: 20))
                }
                .padding(.vertical, 15)
                
                Spacer()
            }
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text("кэшбек")
                        .foregroundColor(Color(hex: textColor))
                        .font(.system(size: 15))
                        .padding(.bottom, 3)
                    Text("\(cashback)%")
                        .padding(.bottom, 7)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                VStack (alignment: .leading) {
                    Text("Уровень")
                        .foregroundColor(Color(hex: textColor))
                        .font(.system(size: 15))
                        .padding(.bottom, 3)
                    Text(levelName)
                        .padding(.bottom, 7)
                        .font(.system(size: 20))
                }
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    //"http://jsonplaceholder.typicode.com/posts"
                    
            
                    // good solution from article
                    func takeAllCompaniesIdeal() async throws -> [Responce] {
                        let parameters = ["offset": 0]
                        let headers: HTTPHeaders = [
                            "TOKEN" : "123",
                            "Content-Type" : "application/json"
                        ]
                        
                        return try await withCheckedThrowingContinuation({ continuation in
                            AF.request("http://dev.bonusmoney.pro/mobileapp/getAllCompaniesIdeal",
                                       method: .post,
                                       parameters: parameters,
                                       encoding: JSONEncoding.default,
                                       headers: headers
                            ).response { responce in
                                
                            }
                        })
                    }
                    
                }, label: {
                    Image("eyeWhite")
                        .resizable()
                        .colorMultiply(Color(hex: mainColor))
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                })
                .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image("trashWhite")
                        .resizable()
                        .colorMultiply(Color(hex: accentColor))
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Подробнее")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 40)
                        .foregroundColor(Color(hex: mainColor))
                        .background(Color(hex: backgroundColor))
                        .cornerRadius(15)
                })
            }
            .padding(.top, 7)
        }
        .padding(15)
        .background(Color(hex: cardBackgroundColor))
        .cornerRadius(30)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(companyName: "", logoUrl: "", points: 0, levelName: "", cashback: 0, cardBackgroundColor: "", highlightTextColor: "", textColor: "", mainColor: "", accentColor: "", backgroundColor: "")
    }
}
