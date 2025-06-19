//
//  ContentView.swift
//  NoCaTra
//
//  Created by Sam Hirth on 4/20/25.
//
import SwiftUI

struct ContentView: View {
    @State private var refreshID = UUID()
    @StateObject private var unlockableViewModel = UnlockableViewModel()
    var body: some View {
        TabView {
            TrackerView(unlockableViewModel: unlockableViewModel)
                .tabItem {
                    Label("Track", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            
            CalendarTabView(unlockableViewModel: unlockableViewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0)
            
            UnlockableView(unlockableViewModel: unlockableViewModel)
                .tabItem {
                    Label("Unlock", systemImage: "lock.fill")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
        .id(refreshID)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("FullAppRefresh"))) { _ in
            refreshID = UUID()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
