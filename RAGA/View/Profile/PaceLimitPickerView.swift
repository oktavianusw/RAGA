import SwiftUI

struct PaceLimitPickerView: View {
    let title: String
    @Binding var pace: Pace
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.appGreen.ignoresSafeArea()

            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()

                HStack(spacing: 0) {
                    Picker("Minutes", selection: $pace.minutes) {
                        ForEach(0..<60) { minute in
                            Text(String(format: "%02d", minute)).tag(minute)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .compositingGroup() // Fixes transparency issues

                    Text("'")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Picker("Seconds", selection: $pace.seconds) {
                        ForEach(0..<60) { second in
                            Text(String(format: "%02d", second)).tag(second)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .compositingGroup()

                    Text("\" /KM")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .colorInvert() // Wheels are black on white, this flips them
                .colorMultiply(.white) // Then recolors the text to white

                Spacer()

                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Text("Set")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.appGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appCream)
                        .cornerRadius(15)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}


fileprivate struct PaceLimitPickerView_PreviewWrapper: View {
    @State private var pace = Pace(minutes: 8, seconds: 30)
    
    var body: some View {
        PaceLimitPickerView(title: "Upper Limit", pace: $pace)
    }
}

#Preview {
    PaceLimitPickerView_PreviewWrapper()
}
