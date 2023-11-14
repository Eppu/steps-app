//
//  ActivityCard.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}

struct ActivityCard: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(activity.title).font(.system(size:16, weight: .bold))
                        
                        Text(activity.subtitle).font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                    Spacer()
                    Image(systemName: activity.image).foregroundColor(.green)
                }.padding()
                Text(activity.amount)
                    .font(.system(size: 24))
                
                
            }.padding(.bottom)
        }
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 1, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: "7364"))
}
