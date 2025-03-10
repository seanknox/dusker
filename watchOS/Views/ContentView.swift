import SwiftUI
import DuskerKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    // Start session action
                }) {
                    Text("Start Session")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: Text("History View")) {
                    Text("History")
                        .font(.body)
                        .foregroundColor(.white)
                }
                
                NavigationLink(destination: Text("Settings View")) {
                    Text("Settings")
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("Dusker")
        }
        .accentColor(Color("AccentColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 