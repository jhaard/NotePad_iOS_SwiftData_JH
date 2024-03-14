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
    @State private var showSearchResults = false
    @State private var showNoteList = true
    @State private var showDelete = false
    @State private var showAnimation = false
    
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
                    .autocapitalization(.none)
                    .padding(12)
                    .font(.title3)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.appDark, lineWidth: 2)
                    )
                    .padding()
                    .onChange(of: textToSearch, initial: false) { oldValue, newValue in
                        showNoteList = false
                        showSearchResults = true
                        
                        if newValue.isEmpty {
                            showNoteList = true
                            showSearchResults = false
                        }
                    }
                
                if showSearchResults {
                    List{
                        ForEach(noteViewModel.searchThroughLibrary(search: textToSearch)) { entity in
                            VStack {
                                ZStack {
                                    Text("\(entity.title)\n\n\(entity.bodyText)")
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
                                                .stroke(.green, lineWidth: 4)
                                        )
                                        .opacity(showAnimation ? 0.5 : 1)
                                        .onTapGesture {
                                            id = entity.id
                                            title = entity.title
                                            bodyText = entity.bodyText
                                            note = entity
                                            isSheetVisible = false
                                        }
                                        .onLongPressGesture {
                                            showDelete = true
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.4)) {
                                                showAnimation = true
                                            }
                                        }
                                    
                                    if showDelete {
                                        Image(systemName: "xmark.rectangle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(.red)
                                            .onTapGesture {
                                                showAnimation = false
                                                noteViewModel.deleteNote(entity: entity)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .onTapGesture {
                        showDelete = false
                        showAnimation = false
                    }
                }
                
                if showNoteList {
                    List{
                        ForEach(noteViewModel.notes) { entity in
                            VStack {
                                ZStack {
                                    Text("\(entity.title)\n\n\(entity.bodyText)")
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
                                        .opacity(showAnimation ? 0.5 : 1)
                                        .onTapGesture {
                                            id = entity.id
                                            title = entity.title
                                            bodyText = entity.bodyText
                                            note = entity
                                            isSheetVisible = false
                                        }
                                        .onLongPressGesture {
                                            showDelete = true
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.4)) {
                                                showAnimation = true
                                            }
                                        }
                                    if showDelete {
                                        Image(systemName: "xmark.rectangle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(.red)
                                            .onTapGesture {
                                                showAnimation = false
                                                noteViewModel.deleteNote(entity: entity)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .onTapGesture {
                        showDelete = false
                        showAnimation = false
                    }
                }
            }.padding()
        }
    }
}
