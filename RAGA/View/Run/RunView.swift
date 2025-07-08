import SwiftUI

struct RunView: View {
    @ObservedObject var viewModel: RunViewModel
    let onFinish: () -> Void
    
    @State private var navigateToSummary = false
    
    var body: some View {
        ZStack {
            // Background
            VStack(spacing: 0) {
                Color.appGreen
                Color.appBlue
            }
            .ignoresSafeArea()
            
            VStack {
                // Top Metrics
                VStack(spacing: 30) {
                    VStack {
                        Text("TOTAL DURATION")
                            .foregroundColor(.white.opacity(0.8))
                        Text(viewModel.formattedDuration)
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                    }
                    VStack {
                        Text("TOTAL DISTANCE")
                            .foregroundColor(.white.opacity(0.8))
                        Text(viewModel.formattedDistance)
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.white)
                        Text("KM")
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Bottom Panel
                VStack(spacing: 20) {
                    hrZoneBar
                    
                    HStack(spacing: 50) {
                        MetricDisplayView(label: "HEART RATE", value: "\(viewModel.currentHeartRate)", unit: "BPM")
                        MetricDisplayView(label: "AVG PACE", value: viewModel.currentPace.displayString, unit: "/KM")
                    }
                    
                    runControls
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            viewModel.startRun()
        }
        .onChange(of: viewModel.isFinished) { finished in
            if finished {
                onFinish()
            }
        }
    }
    
    private var hrZoneBar: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 2) {
                ForEach(0..<5) { i in
                    Color.zoneColors[i]
                }
            }
            .frame(height: 30)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 2)
            )
            
            Text("Zone \(viewModel.currentZone)")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(5)
                .offset(x: calculateZoneIndicatorOffset())
                .animation(.easeInOut, value: viewModel.currentZone)
        }
        .padding(.horizontal, 30)
    }

    private func calculateZoneIndicatorOffset() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width - 60
        let barWidth = screenWidth
        let sectionWidth = barWidth / 5.0
        let offset = (sectionWidth * CGFloat(viewModel.currentZone - 1)) + (sectionWidth / 2) - 25
        return offset
    }
    
    private var runControls: some View {
        HStack(spacing: 20) {
            ControlButton(icon: "speaker.wave.2.fill", label: "HR")
            
            if viewModel.isRunning {
                Button(action: viewModel.pauseRun) {
                    Image(systemName: "pause.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.appGreen)
                        .frame(width: 80, height: 80)
                        .background(Color.appCream)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            } else {
                 Button(action: viewModel.resumeRun) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.appGreen)
                        .frame(width: 80, height: 80)
                        .background(Color.appCream)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            
            Button(action: viewModel.stopRun) {
                Image(systemName: "xmark")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 80, height: 80)
                    .background(Color.appRed)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            ControlButton(icon: "speaker.wave.2.fill", label: "Pace")
        }
    }
}

// THIS WAS THE MISSING PIECE
struct ControlButton: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}


fileprivate struct RunView_PreviewWrapper: View {
    var body: some View {
        RunView(viewModel: RunViewModel(settings: UserSettings()), onFinish: {})
    }
}

#Preview {
    RunView_PreviewWrapper()
}
