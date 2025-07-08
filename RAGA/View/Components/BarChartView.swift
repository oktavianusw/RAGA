import SwiftUI

// A simple placeholder bar chart for the home screen
struct BarChartView: View {
    let data: [CGFloat] = [0.3, 0.5, 0.9, 0.4, 0.7, 0.2, 0.6]

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(0..<data.count, id: \.self) { index in
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.appGreen.opacity(0.6))
                        .frame(height: data[index] * 80) // 80 is max height
                }
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    BarChartView()
        .padding()
        .background(Color.appCream)
}
