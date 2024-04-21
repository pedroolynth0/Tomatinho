//
//  CustomAlertView.swift
//  PomodoroApp
//
//  Created by Pedro Olyntho on 21/04/24.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let text: String
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            // Fundo escurecido
            if isPresented {
                Color.black.opacity(0.5) // Transparência para escurecer o fundo
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut)
            }

            if isPresented {
                VStack(spacing: 0) {
                    Text(title)
                        .font(.custom("ZillaSlab-Bold", size: 20))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))

                    Text(text)
                        .font(.custom("ZillaSlab-Regular", size: 14))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .padding(.horizontal, 45)
                    
                    Divider()
                        .frame(height: 0.5)
                        .background(Color(UIColor.mainColor.asColor))
                        .padding(.top, 23)

                    Button(action: {
                        isPresented = false 
                    }) {
                        Text("Ok")
                            .font(.custom("ZillaSlab-Bold", size: 20))
                            .foregroundStyle(Color(UIColor.mainColor.asColor))
                            .padding(8)
                    }
                }
                .background(Color.white) 
                .cornerRadius(15)
                .shadow(radius: 10)
                .transition(.scale)
                .padding(24)
            }
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showAlert = true

        CustomAlertView(title: "Conexão não efetuada", text: "Não foi possível conectar ao dispositivo. Tente novamente.", isPresented: $showAlert)
    }
}
