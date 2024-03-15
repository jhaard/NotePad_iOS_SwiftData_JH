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
    
    /// Adding a new note.
    /// - Parameters:
    ///      - title: The note-title.
    ///      - bodyText: The note-body-text.
    func addNote(title: String, bodyText: String) {
        let newNote = Note(title: title, bodyText: bodyText)
        modelContext.insert(newNote)
        fetchData()
    }
    
    /// Deletes the chosen note and empties title and text.
    /// - Parameters:
    ///      - entity: Current note.
    func deleteNote(entity: Note) {
        modelContext.delete(entity)
        entity.title = ""
        entity.bodyText = ""
        fetchData()
    }
    
    /// Updates current note if chosen in the sheet.
    /// - Parameters:
    ///      - entity: Current note.
    ///      - newTitle: The new title to update.
    ///      - newBodyText: The new body-text to update.
    func updateNote(entity: Note, newTitle: String, newBodyText: String) {
        entity.title = newTitle
        entity.bodyText = newBodyText
        
        fetchData()
    }
    
    /// Fetches notes.
    func fetchData() {
        do {
            let noteItem = FetchDescriptor<Note>(sortBy: [SortDescriptor(\.title)])
            notes = try modelContext.fetch(noteItem)
        } catch {
            print("Fetch failed")
        }
    }
    
    /// Creates a library with searched notes if search-text matches title or body-text. CASE-SENSITIVE-SEARCH.
    /// - Parameters:
    ///      - search: The search-text.
    /// - Returns:
    ///     A new array of Notes matching search-word.
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

