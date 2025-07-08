import SwiftUI

struct GenderSelectionView: View {
    @Binding var selectedGender: String
    @Environment(\.presentationMode) var presentationMode
    let genders = ["Male", "Female", "Other"]

    var body: some View {
        ZStack {
            Color.appCream.ignoresSafeArea()

            VStack(spacing: 1) {
                ForEach(genders, id: \.self) { gender in
                    Button(action: {
                        selectedGender = gender
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(gender)
                            Spacer()
                            if selectedGender == gender {
                                Image(systemName: "checkmark")
                            }
                        }
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.top, 60)
        }
        .navigationTitle("Gender")
        .navigationBarTitleDisplayMode(.inline)
    }
}


fileprivate struct GenderSelectionView_PreviewWrapper: View {
    @State private var gender = "Male"
    
    var body: some View {
        NavigationStack {
             GenderSelectionView(selectedGender: $gender)
        }
    }
}

#Preview {
    GenderSelectionView_PreviewWrapper()
}
