//
//  MessageView.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

// View

import SwiftUI

struct MessageView: View {
    var message: String
    var color: Color
    var systemImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 50)
                .foregroundStyle(color)
                .opacity(0.5)
            
                .padding()
            HStack {
                Image(systemName: systemImage)
                Text(message)
                    .foregroundStyle(.appDark)
                    .multilineTextAlignment(.center)
            }
            
        }
    }
}

#Preview {
    MessageView(message: "Example", color: Color.blue, systemImage: "questionmark")
}
