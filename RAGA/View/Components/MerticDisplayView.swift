import SwiftUI

struct MetricDisplayView: View {
    let label: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
            Text(value)
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
            Text(unit)
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

#Preview {
    ZStack {
        Color.appBlue
        MetricDisplayView(label: "HEART RATE", value: "126", unit: "BPM")
    }
}
