//
//  HRAlertView.swift
//  RAGA
//
//  Created by Waluya Juang Husada on 09/07/25.
//

import SwiftUI

struct PaceAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.top)
            Text("HR Alert Settings")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 8)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PaceAlertView()
}

