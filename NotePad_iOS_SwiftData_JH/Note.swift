// Model

import Foundation
import SwiftData

@Model
class Note {
    var id = UUID()
    var title: String
    var bodyText: String
    
    init(title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
    }
    
}
