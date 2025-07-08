import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var isShowingRecordRunSheet = false
    @State private var isShowingRunView = false
    @State private var isShowingSummaryView = false
    @State private var runViewModel: RunViewModel?

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Text("RAGA")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // Illustration Placeholder
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 150)
                    .cornerRadius(20)
                    .overlay(Text("Illustration Placeholder").foregroundColor(.white))
                    .padding(.horizontal)
                
                // Welcome Text
                VStack(alignment: .leading, spacing: 8) {
                    Text("You are doing great!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla imperdiet sodales purus. Pellentesque habitant morbi tristique.")
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.horizontal)
                
                // Sessions Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Sessions")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .font(.headline)
                    
                    Text("This Week")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("22,3 KM")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    BarChartView()
                    
                }
                .padding()
                .background(Color.appCream)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer()
                
                // Record Run Button
                Button(action: {
                    isShowingRecordRunSheet = true
                }) {
                    Text("Record Run")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.appGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appCream)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.top)
        }
        .sheet(isPresented: $isShowingRecordRunSheet) {
            // The NavigationStack is crucial for navigation *within* the sheet
            NavigationStack {
                RecordRunView(
                    isPresented: $isShowingRecordRunSheet,
                    onStartRun: { viewModel in
                        runViewModel = viewModel
                        isShowingRecordRunSheet = false
                        isShowingRunView = true
                    }
                )
                .environmentObject(userSettings)
            }
            .presentationDetents([.fraction(0.5)])
        }
        .fullScreenCover(isPresented: $isShowingRunView) {
            RunView(
                viewModel: runViewModel ?? RunViewModel(settings: userSettings),
                onFinish: {
                    isShowingRunView = false
                    isShowingSummaryView = true
                }
            )
        }
        .fullScreenCover(isPresented: $isShowingSummaryView) {
            SummaryView(
                onDone: {
                    isShowingSummaryView = false
                    runViewModel = nil
                }
            )
            .environmentObject(userSettings)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(UserSettings())
    }
}
