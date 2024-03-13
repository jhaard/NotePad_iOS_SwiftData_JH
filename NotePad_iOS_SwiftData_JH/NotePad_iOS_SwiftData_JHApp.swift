//
//  NotePad_iOS_SwiftData_JHApp.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

import SwiftUI
import SwiftData

@main
struct NotePad_iOS_SwiftData_JHApp: App {
    
    let container: ModelContainer

        var body: some Scene {
            WindowGroup {
                NewNoteView(modelContext: container.mainContext)
            }
            .modelContainer(container)
        }

        init() {
            do {
                container = try ModelContainer(for: Note.self)
            } catch {
                fatalError("Failed to create ModelContainer for Notes.")
            }
        }
}
