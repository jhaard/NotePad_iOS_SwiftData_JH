//
//  Note.swift
//  NotePad_iOS_SwiftData_JH
//
//  Created by Jörgen Hård on 2024-02-16.
//

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
