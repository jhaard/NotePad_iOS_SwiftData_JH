//
//  ContentView.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

// View

import SwiftUI
import SwiftData

struct EditNoteView: View {
    
    @State private var noteViewModel: NoteViewModel
    
    @State var id: UUID = UUID()
    @State var title: String = ""
    @State var bodyText: String = ""
    @State var note: Note = Note(title: "", bodyText: "")
    
    @State private var showSaveMessage = false
    @State private var showErrorMessage = false
    @State private var isSheetVisible: Bool = false
    
    init(modelContext: ModelContext) {
        let noteViewModel = NoteViewModel(modelContext: modelContext)
        _noteViewModel = State(initialValue: noteViewModel)
    }
    
    var body: some View {
        // Overall VStack.
        VStack {
            
            // Headline.
            Text("Edit Note")
                .font(.title)
                .foregroundStyle(.appLight)
            
            // Title-field.
            TextField("Title", text: $title)
                .padding(10)
                .background(.white)
                .cornerRadius(10)
                .foregroundStyle(.appDark)
                .multilineTextAlignment(.center)
                .font(.title2)
            
            // ZStack so pop-up-message will overlay texteditor when displaying it on the screen.
            ZStack {
                TextEditor(text: $bodyText)
                    .cornerRadius(10)
                    .foregroundStyle(.appDark)
                
                if showSaveMessage {
                    MessageView(message: "Updating...", color: Color.green, systemImage: "plus.rectangle.on.folder")
                    
                } else if showErrorMessage {
                    MessageView(message: "Can't save with empty title...", color: Color.red, systemImage: "exclamationmark.octagon")
                    
                }
            }
            
            // HStack for bottom-buttons.
            HStack {
                // Save/update-button.
                Button(action:  {
                    if !title.isEmpty {
                        saveNote()
                        showSaveMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSaveMessage = false
                        }
                    } else {
                        showErrorMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showErrorMessage = false
                        }
                    }
                    
                }, label: {
                    Image(systemName: "checkmark.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(showErrorMessage ? .red : .green)
                })
                
                Spacer()
                
                // Button opens sheet with saved notes.
                Button(action:  {
                    isSheetVisible.toggle()
                    
                }, label: {
                    Image(systemName: "folder")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.appLight)
                }) .sheet(isPresented: $isSheetVisible, content: {
                    NoteSheetView(noteViewModel: noteViewModel, isSheetVisible: $isSheetVisible, id: $id, title: $title, note: $note, bodyText: $bodyText)
                })
                
            }
            .padding()
        }
        .padding(20)
        .background(.appDark)
    }
    
    // Save note from viewmodel when id is new, else update note and clean.
    func saveNote() {
        if title.isEmpty {
            return
        }
        
        if note.id == id {
            noteViewModel.updateNote(entity: note, newTitle: title, newBodyText: bodyText)
            title = ""
            bodyText = ""
            id = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
        }
        
        else {
            noteViewModel.addNote(title: title, bodyText: bodyText)
            title = ""
            bodyText = ""
        }
    }
}
