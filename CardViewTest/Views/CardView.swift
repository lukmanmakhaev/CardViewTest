//
//  CardView.swift
//  CardViewTest
//
//  Created by Lukman Makhaev on 15.04.2023.
//

import Foundation
import SwiftUI

struct CardView: View {
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Text("Bonus Money")
                    .font(.system(size: 25))
                
                Spacer()
                
                Image(systemName: "heart")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Circle())
                    .padding(.bottom, 7)
            }
            
            Divider()
            
            HStack (alignment: .bottom){
                
                VStack {
                    Text("200")
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                    
                    
                    + Text(" баллов")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                .padding(.vertical, 15)
                
                Spacer()
            }
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text("Кэшбек")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .padding(.bottom, 7)
                    Text("1 %")
                        .padding(.bottom, 7)
                }
                
                Spacer()
                
                VStack (alignment: .leading) {
                    Text("Уровень")
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .padding(.bottom, 7)
                    Text("Базовый уровень тест")
                        .padding(.bottom, 7)
                }
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    
                }, label: {
                    Image("eyeWhite")
                        .resizable()
                        .colorMultiply(.blue)
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                })
                .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image("trashWhite")
                        .resizable()
                        .colorMultiply(.red)
                        .frame(width: 25, height: 25)
                        .scaledToFit()
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Подробнее")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 40)
                        .background(Color(hex: "efefef"))
                        .cornerRadius(15)
                })
            }
            .padding(.top, 7)
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(30)
    }
}
