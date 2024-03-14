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
    
    func deleteNote(entity: Note) {
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
    
    func searchThroughLibrary(search: String) -> [Note] {
        var searchedNotes = [Note]()
        for entity in notes {
            if entity.title.contains(search) || entity.bodyText.contains(search) {
                searchedNotes.append(entity)
            }
        }
        return searchedNotes
    }
}

