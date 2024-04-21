//
//  AboutView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            TitleView(title: "Configuração Timer")
                .padding(.top, 29)
            text
            image
            Spacer()
        }
        
    }
    
    var text: some View {
        Text("A Técnica Pomodoro™ é um método de gestão do tempo desenvolvido por Francesco Cirillo no final da década de 1980. Consiste em períodos de 25 minutos  de   trabalho focado, interrompidos por intervalos de 5 minutos.  Após 04 intervalos de estudo consecutivos, são  feitos  intervalos mais longos, que podem variar de 15 a 30 minutos.")
            .padding(EdgeInsets(top: 59, leading: 28, bottom: 38, trailing: 28))
            .font(.custom("ZillaSlab-Regular", size: 14))
            .foregroundStyle(Color(UIColor.mainColor.asColor))
            .lineSpacing(10.0)
    }
    
    var image: some View {
        Image("pomodoro")
            .resizable()
            .scaledToFit()
            .frame(width: 333)
            .padding(.leading, 28)
    }
}

#Preview {
    AboutView()
}
