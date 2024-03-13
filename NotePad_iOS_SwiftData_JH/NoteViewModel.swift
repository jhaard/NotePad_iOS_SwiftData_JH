//
//  NoteViewModel.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

// ViewModel

import Foundation
import SwiftData

@Observable
class NoteViewModel {
    
    var modelContext: ModelContext
    var notes = [Note]()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    func addNote(title: String, bodyText: String) {
        let newNote = Note(title: title, bodyText: bodyText)
        modelContext.insert(newNote)
        fetchData()
    }
    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = notes[index]
        modelContext.delete(entity)
        fetchData()
    }
    
    func updateNote(entity: Note, newTitle: String, newBodyText: String) {
        entity.title = newTitle
        entity.bodyText = newBodyText
        
        fetchData()
    }
    
    func fetchData() {
        do {
            let noteItem = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.title)])
            notes = try modelContext.fetch(noteItem)
        } catch {
            print("Fetch failed")
        }
    }
}

