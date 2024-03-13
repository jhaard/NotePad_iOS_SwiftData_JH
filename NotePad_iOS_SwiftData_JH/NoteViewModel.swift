//
//  NoteViewModel.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

import Foundation
import SwiftData

extension ContentView {
    @Observable
    class NoteViewModel {
        var modelContext: ModelContext
        var notes = [Note]()

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }

        func addSample() {
            let movie = Movie(title: "Avatar", cast: ["Sam Worthington", "Zoe Saldaña", "Stephen Lang", "Michelle Rodriguez"])
            modelContext.insert(movie)
            fetchData()
        }

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Movie>(sortBy: [SortDescriptor(\.title)])
                movies = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
    }
}
