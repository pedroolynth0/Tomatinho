//
//  TomatoView.swift
//  PomodoroApp
//
//
//

import SwiftUI


struct TomatoView: View {
    @State var isActive: Bool = false
    @State private var opacity = 1.0
    var body: some View {
        VStack{
            if isActive {
                MainTabView()
            } else {
                VStack{
                    Image("tomato")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 210)
                    Text("Tomatinho")
                        .foregroundStyle(Color(UIColor.mainColor.asColor))
                        .font(.custom("ZillaSlab-Bold", size: 36))
                }
            }
        }
        .animation(.easeInOut(duration: 1.0), value: opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    TomatoView()
}
