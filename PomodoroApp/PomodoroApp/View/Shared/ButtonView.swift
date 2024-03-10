//
//  ButtonView.swift
//  PomodoroApp
//
//  Created on 10/03/24.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    var action: () -> Void
    
    init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body)
                .frame(width: 21, height: 21)
                .foregroundStyle(Color(UIColor.mainColor.asColor))
                .background(Color(UIColor.buttonColor.asColor))
                .cornerRadius(30)
    }
    }
}

#Preview {
    ButtonView(text: "-") {}
}
