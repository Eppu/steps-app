//
//  ActivityCard.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Steps today").font(.system(size:16, weight: .bold))
                        
                        Text("Something").font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                    Spacer()
                    Image(systemName: "figure.walk").foregroundColor(.green)
                }.padding()
                Text("7364")
                    .font(.system(size: 24))
                
                
            }.padding(.bottom)
        }
    }
}

#Preview {
    ActivityCard()
}
