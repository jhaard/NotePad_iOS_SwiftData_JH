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
    
    @State var noteViewModel: NoteViewModel
    
    @Binding var isSheetVisible: Bool
    
    @Binding var id: UUID
    @Binding var title: String
    @Binding var note: Note
    @Binding var bodyText: String
    
    @State private var textToSearch = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Button(action:  {
                    isSheetVisible = false
                    
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.appDark)
                })
 
                TextField("Search..", text: $textToSearch)
                    .padding(12)
                    .font(.title3)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.appDark, lineWidth: 2)
                    )
                    .padding()
                
                List{
                    ForEach(noteViewModel.notes) { entity in
                        VStack {
                            
                            Text("\(entity.title.uppercased())\n\n\(entity.bodyText)")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .bold()
                                .lineLimit(5)
                                .padding()
                                .background(.appDark)
                                .cornerRadius(10)
                                .foregroundStyle(.appLight)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.appLight, lineWidth: 2)
                                )
                                .onTapGesture {
                                    id = entity.id
                                    title = entity.title
                                    bodyText = entity.bodyText
                                    note = entity
                                    isSheetVisible = false
                                }
                        }
                    }
                    .onDelete (
                        perform: { indexSet in noteViewModel.deleteNote(indexSet: indexSet)
                            
                        }
                    )
                }
                .listStyle(.plain)
            }.padding()
        }
        
    }
}
