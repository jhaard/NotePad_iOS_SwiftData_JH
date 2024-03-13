//
//  NoteSheetView.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

// View

import SwiftUI
import SwiftData

struct NoteSheetView: View {
    
    @State private var isSheetVisible = false
    @State var noteViewModel: NoteViewModel
    
    @State private var textToSearch = ""
    
    @State var title: String = ""
    @State var bodyText: String = ""
    
    var body: some View {
        
        Button(action:  {
            isSheetVisible.toggle()
            
        }, label: {
            Image(systemName: "folder")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.appLight)
        })
        
        .sheet(isPresented: $isSheetVisible) {
            
            NavigationView {
                
                VStack {
                    
                    Text("Notes".uppercased())
                        .font(.title3)
                        .underline(true, color: .appDark)
                        .bold()
                        .foregroundColor(.appDark)
                        .padding()
                    
                    TextField("Search..", text: $textToSearch)
                        .padding(12)
                        .font(.title3)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.appDark, lineWidth: 2)
                        )
                        .padding(20)
                    
                    List{
                        ForEach(noteViewModel.notes) { entity in
                            VStack {
                                NavigationLink {
                                    
                                    EditView(note: entity, noteViewModel: noteViewModel)
                                    
                                } label: {
                                    
                                    Text("\(entity.title.uppercased())\n\n\(entity.bodyText)")
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                        .bold()
                                        .lineLimit(5)
                                        .padding(20)
                                        .background(.appDark)
                                        .cornerRadius(10)
                                        .foregroundColor(.appLight)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.appLight, lineWidth: 2)
                                        )
                                }
                            }
                        }
                        .onDelete (
                            perform: { indexSet in noteViewModel.deleteNote(indexSet: indexSet)
                                
                            }
                        )
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}





