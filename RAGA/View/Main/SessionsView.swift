import SwiftUI

struct SessionsView: View {
    @ObservedObject var viewModel: SessionsViewModel
    
    var body: some View {
        ZStack {
            Color(hex: "1E2F06")
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {

                
                
                
                Text("Sessions")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                
                ScrollView {
                
                // Summary Card
                VStack(alignment: .leading, spacing: 8) {
                    Text("All Records")
                        .font(.title2).bold()
                        .foregroundColor(Color(hex: "FFFADD"))
                    Divider().background(Color(hex: "FFFADD").opacity(0.2))
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
                .background(Color(hex: "6A8043").opacity(0.5))
                .cornerRadius(20)
                
                // Session List
                
                    VStack(spacing: 16) {
                        ForEach(Array(viewModel.sessions.enumerated()), id: \ .offset) { index, session in
                            NavigationLink(destination: SessionDetailView(run: session)) {
                                SessionCardView(session: session, index: index)
                            }
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
        let calendar = Calendar.current
        if calendar.isDateInToday(session.date) {
            return "Today"
        } else if calendar.isDateInYesterday(session.date) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            return formatter.string(from: session.date)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3).bold().foregroundColor(Color(hex: "FFFADD"))
                Text("\(String(format: "%.2f", session.totalDistance).replacingOccurrences(of: ".", with: ",")) KM")
                    .font(.title3).foregroundColor(Color(hex: "FFFADD"))
                HStack(spacing: 4) {
                    Text("\(session.averageHeartRate) BPM")
                        .font(.subheadline).foregroundColor(Color(hex: "FFFADD").opacity(0.8))
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(hex: "FFFADD").opacity(0.8))
                        .font(.subheadline)
                }
            }
            Spacer()
            Image(systemName: "figure.run")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "FFFADD"))
        }
        .padding()
        .background(Color(hex: "6A8043").opacity(0.5))
        .cornerRadius(20)
    }
}

// Preview
struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView(viewModel: SessionsViewModel())
            .preferredColorScheme(.dark)
    }
} 
