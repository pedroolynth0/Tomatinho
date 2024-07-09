//
//  AboutView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            TitleView(title: "A Técnica Pomodoro")
                .padding(.top, 29)
            ScrollView {
                text
                image
                    .padding(.top, 32)
                Spacer()
            }
        }
    }
    
    var text: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("A ")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Regular", size: 16))
            + Text("Técnica Pomodoro™ ")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Bold", size: 16))
            + Text(" é um método de gestão do tempo desenvolvido por Francesco Cirillo no final da década de 1980. Consiste em períodos de ")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Regular", size: 16))
            + Text("25 minutos ")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Bold", size: 16))
            + Text("de trabalho focado, interrompidos por intervalos de ")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Regular", size: 16))
            + Text("5 minutos.")
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .font(.custom("ZillaSlab-Bold", size: 16))


            Text("Após 04 intervalos de estudo consecutivos, são feitos intervalos mais longos, que podem variar de 15 a 30 minutos.")
                    .foregroundStyle(Color(UIColor.mainColor.asColor))
                    .font(.custom("ZillaSlab-Regular", size: 16))
        }
        .padding(.top, 38)
        .padding(.horizontal, 33)
    }
    
    var image: some View {
        Image("pomodoro")
            .resizable()
            .scaledToFit()
            .frame(width: 333)
    }
}

#Preview {
    AboutView()
}
