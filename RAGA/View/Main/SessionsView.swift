import SwiftUI

struct SessionsView: View {
    @StateObject private var viewModel = SessionsViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Button(action: { /* Navigation back action */ }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.title3)
                    Spacer()
                }
                .padding(.top, 8)
                
                
                
                Text("Sessions")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                
                ScrollView {
                
                // Summary Card
                VStack(alignment: .leading, spacing: 8) {
                    Text("All Records")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                    Divider().background(Color.white.opacity(0.2))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TOTAL DISTANCE")
                                .font(.caption2).foregroundColor(.white.opacity(0.7))
                            Text("\(viewModel.formattedTotalDistance)KM")
                                .font(.title2).bold().foregroundColor(.white)
                        }
                        Spacer()
                    }
                    Divider().background(Color.white.opacity(0.2))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("HIGHEST DISTANCE")
                                .font(.caption2).foregroundColor(.white.opacity(0.7))
                            Text("\(viewModel.formattedHighestDistance) KM")
                                .font(.title2).bold().foregroundColor(.white)
                        }
                        Spacer()
                    }
                    Divider().background(Color.white.opacity(0.2))
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("HIGHEST PACE")
                                .font(.caption2).foregroundColor(.white.opacity(0.7))
                            Text(viewModel.formattedHighestPace)
                                .font(.title2).bold().foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(20)
                
                // Session List
                
                    VStack(spacing: 16) {
                        ForEach(Array(viewModel.sessions.enumerated()), id: \ .offset) { index, session in
                            SessionCardView(session: session, index: index)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct SessionCardView: View {
    let session: RunData
    let index: Int
    
    var title: String {
        switch index {
        case 0: return "Today"
        case 1: return "Yesterday"
        case 2: return "15 Jul"
        default: return "Session"
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3).bold().foregroundColor(.white)
                Text("\(String(format: "%.2f", session.totalDistance).replacingOccurrences(of: ".", with: ",")) KM")
                    .font(.title3).foregroundColor(.white)
                HStack(spacing: 4) {
                    Text("\(session.averageHeartRate) BPM")
                        .font(.subheadline).foregroundColor(.white.opacity(0.8))
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white.opacity(0.8))
                        .font(.subheadline)
                }
            }
            Spacer()
            Image(systemName: "figure.run")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.orange)
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(20)
    }
}

// Preview
struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView()
            .preferredColorScheme(.dark)
    }
} 
