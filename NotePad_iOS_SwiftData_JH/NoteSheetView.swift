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
            
            // Overall VStack
            VStack {
                // Button to close sheet with saved notes
                Button(action:  {
                    isSheetVisible = false
                    
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.appDark)
                })
                
                // Search-field
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
                
                // Only Showing a new list when searching. Simple search, Case-sensitive.
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
                                    
                                    // If one of the entities are pressed with long-press, show delete-buttons.
                                    if showDelete {
                                        Image(systemName: "xmark.rectangle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(.red)
                                            .onTapGesture {
                                                title = ""
                                                bodyText = ""
                                                id = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
                                                showAnimation = false
                                                noteViewModel.deleteNote(entity: entity)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    // If tap on side of the list, hide delete-buttons.
                    .listStyle(.plain)
                    .onTapGesture {
                        showDelete = false
                        showAnimation = false
                    }
                }
                
                // Showing saved list of notes i normal state.
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
                                    
                                    // Showing same delete-buttons with long-press.
                                    if showDelete {
                                        Image(systemName: "xmark.rectangle")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(.red)
                                            .onTapGesture {
                                                title = ""
                                                bodyText = ""
                                                id = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
                                                showAnimation = false
                                                noteViewModel.deleteNote(entity: entity)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    // If tap on side of the list, hide delete-buttons.
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
