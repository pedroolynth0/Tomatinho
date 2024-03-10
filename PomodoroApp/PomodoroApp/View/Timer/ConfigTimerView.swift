//
//  ConfigTimerView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct ConfigTimerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 90) {
            TitleView(title: "Configuração Timer")
                .padding(.top, 29)
            
            VStack(spacing: 50) {
                rounds
                    .padding(.leading, 33)
                
                focusTime
                    .padding(.leading, 33)
                
                quickStop
                    .padding(.leading, 33)
                
                longStop
                    .padding(.leading, 33)
            }
            
            button
            Spacer()
        }
    }
    
    var button: some View {
        HStack {
            Spacer()
            Button(action: {
                
            }) {
                Image("play")
                    .foregroundStyle(Color.white)
                    .frame(width: 43, height: 43)
                    .padding(24)
                    .background(Color(UIColor.playButtonColor.asColor))
                    .clipShape(Circle())
            }
            Spacer()
        }
        
    }
    var rounds: some View {
        HStack {
            Text("Rounds")
                .font(.custom("ZillaSlab-Medium", size: 20))
            Spacer()
            HStack {
                ButtonView(text: "-") {}
                Text("04")
                    .frame(width: 55)
                    .font(.custom("ZillaSlab-Regular", size: 20))
                ButtonView(text: "+") {}
            }
            .frame(width: 128)
            .padding(.trailing, 58)
        }
    }
    
    var focusTime: some View {
        HStack {
            Text("Tempo de Foco")
                .font(.custom("ZillaSlab-Medium", size: 20))
            Spacer()
            HStack {
                ButtonView(text: "-") {}
                Text("25:00")
                    .frame(width: 55)
                    .font(.custom("ZillaSlab-Regular", size: 20))
                ButtonView(text: "+") {}
            }
            .frame(width: 128)
            .padding(.trailing, 58)
        }
    }
    
    var quickStop: some View {
        HStack {
            Text("Pausa Curta")
                .font(.custom("ZillaSlab-Medium", size: 20))
            Spacer()
            HStack {
                ButtonView(text: "-") {}
                Text("05:00")
                    .frame(width: 55)
                    .font(.custom("ZillaSlab-Regular", size: 20))
                ButtonView(text: "+") {}
            }
            .frame(width: 128)
            .padding(.trailing, 58)
        }
    }
    
    var longStop: some View {
        HStack {
            Text("Pausa Longa")
                .font(.custom("ZillaSlab-Medium", size: 20))
            Spacer()
            HStack {
                ButtonView(text: "-") {}
                Text("30:00")
                    .frame(width: 55)
                    .font(.custom("ZillaSlab-Regular", size: 20))
                ButtonView(text: "+") {}
            }
            .frame(width: 128)
            .padding(.trailing, 58)
        }
    }
}

#Preview {
    ConfigTimerView()
}
