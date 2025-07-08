import SwiftUI

struct SettingsRow: View {
    let title: String
    var value: String? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
            Spacer()
            if let value = value {
                Text(value)
                    .foregroundColor(.gray)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    VStack {
        SettingsRow(title: "Name", value: "John Doe")
        SettingsRow(title: "Action")
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
