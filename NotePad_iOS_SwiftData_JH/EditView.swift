//
//  EditAlertView.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-19.
//

import SwiftUI

struct EditAlertView: View {
    var note: Note
    @State var noteViewModel: NoteViewModel
    
    @State private var title = ""
    @State private var bodyText = ""
    
    var body: some View {
        VStack {
                VStack {
                    TextField("New title...", text: $title)
                        .onAppear {
                            title = note.title
                        }
                        .padding(10)
                        .background(.appLight)
                        .cornerRadius(10)
                        .foregroundColor(.appDark)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.appDark, lineWidth: 2)
                        )
                    
                    TextEditor(text: $bodyText)
                        .onAppear {
                            bodyText = note.bodyText
                        }
                        .padding(10)
                        .cornerRadius(10)
                        .foregroundColor(.appDark)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.appDark, lineWidth: 2)
                        )
                        
                        Button(action:  {
                            
                            noteViewModel.updateNote(entity: note, newTitle: title, newBodyText: bodyText)
                            
                           
                        }, label: {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                        })
                    
                }
                .padding()
            }
        }
}



