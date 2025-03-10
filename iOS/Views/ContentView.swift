import SwiftUI
import DuskerKit

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Sessions")
                .tabItem {
                    Label("Sessions", systemImage: "list.bullet")
                }
            
            Text("Stats")
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(Color("AccentColor"))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 