//
//  ContentView.swift
//  RAGA-WatchApp Watch App
//
//  Created by Waluya Juang Husada on 09/07/25.
//

import SwiftUI
import WatchConnectivity

// MARK: - Root container
struct ContentView: View {
    var body: some View {
        TabView {
            ReadyView()        // first page
            SetAlert()    // second page
        }
        // page dots (two dots) – hide the grey pill behind them
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        // vertical paging on watchOS 10+, carousel fallback before that
        .applyWatchPagingStyle()
    }
}

// MARK: - First page (unchanged UI, just split into its own view)
private struct ReadyView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ready to run?")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)

            Text("Scroll down below to adjust your running alert")
                .font(.system(size: 15))
                .foregroundColor(.white)
                .frame(width: 154, alignment: .leading)

            Text(Image(systemName: "chevron.down.2"))

            Button {
                // TODO: Add action if needed
            } label: {
                HStack(spacing: 8) {
                    Text("Record Run")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                    Image(systemName: "figure.run")
                        .foregroundColor(.black)
                }
                .frame(width: 192, height: 47)
                .background(Color(red: 1.0, green: 0.98, blue: 0.86)) // #FFFADD
                .cornerRadius(12)
            }
            .padding(.top, 12)
        }
        .frame(width: 208, height: 248)
        .background(
            LinearGradient(
                stops: [
                    .init(color: Color(red: 0.12, green: 0.18, blue: 0.02), location: 0),
                    .init(color: .black, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .padding()
        .onAppear {
            WatchSessionManager.shared.startSession()
        }
    }
}

// MARK: - WatchOS paging helper
private extension View {
    /// Applies the vertical page style on watchOS 10+, otherwise carousel.
    @ViewBuilder
    func applyWatchPagingStyle() -> some View {
        if #available(watchOS 10.0, *) {
            self.tabViewStyle(.verticalPage)     // vertical swipe / Crown scrolling
        } else {
            self.tabViewStyle(.carousel)         // legacy vertical paging
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
