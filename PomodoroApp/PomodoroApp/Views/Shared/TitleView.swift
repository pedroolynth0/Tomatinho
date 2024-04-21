//
//  TitleView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 9) {
                Image("icon")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .frame(width: 33, height: 33)
                    .padding(.leading, 33)
                Text(title)
                    .font(.custom("ZillaSlab-Bold", size: 26))
                    .foregroundStyle(Color(UIColor.mainColor.asColor))
                Spacer()
            }
            
        }
    }
}

#Preview {
    TitleView(title: "Configuração Timer")
}
