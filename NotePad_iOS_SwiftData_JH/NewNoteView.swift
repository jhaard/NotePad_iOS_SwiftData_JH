//
//  ContentView.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

// View

import SwiftUI
import SwiftData

struct NewNoteView: View {
    
    @State private var noteViewModel: NoteViewModel
    
    @State var title: String = ""
    @State var bodyText: String = ""
    
    
    @State private var showSaveMessage = false
    @State private var showErrorMessage = false
    
    init(modelContext: ModelContext) {
        let noteViewModel = NoteViewModel(modelContext: modelContext)
        _noteViewModel = State(initialValue: noteViewModel)
    }
    
    var body: some View {
        
        VStack {
            Text("New note")
                .font(.title)
                .foregroundColor(.appLight)
            
            TextField("Title", text: $title)
                .padding(10)
                .background(.white)
                .cornerRadius(10)
                .foregroundColor(.appDark)
                .multilineTextAlignment(.center)
                .font(.title2)
            
            ZStack {
                TextEditor(text: $bodyText)
                    .cornerRadius(10)
                    .foregroundColor(.appDark)
                
                if showSaveMessage {
                    MessageView(message: "SAVING...", color: Color.green, systemImage: "plus.rectangle.on.folder")
                        .transition(.opacity)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 0.5)
                } else if showErrorMessage {
                    MessageView(message: "Can't save with empty title...", color: Color.red, systemImage: "exclamationmark.octagon")
                        .transition(.opacity)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: 0.5)
                }
            }
            
            HStack {
                Button(action:  {
                    if !title.isEmpty {
                        addNote()
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
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.appLight)
                })
                
                Spacer()
                
                NoteSheetView(noteViewModel: noteViewModel)
                
            }
            .padding()
            
        }
        .padding(20)
        .background(.appDark)
        
    }
    
    func addNote() {
        if title.isEmpty {
            return
        }
        
        noteViewModel.addNote(title: title, bodyText: bodyText)
        title = ""
        bodyText = ""
    }
    
}

