//
//  NotesViewModel.swift
//  AisleTechChallenge
//
//  Created by Shoumik on 09/11/24.
//

import Foundation

final class NotesViewModel {
    struct Profile {
        let imageURL: String
        let name: String
        let dob: String?
    }
    
    var invites: [Profile]
    var likes: [Profile]
    
    init(invites: [Profile] = [], likes: [Profile] = []) {
        self.invites = invites
        self.likes = likes
    }
    
    func loadData(invites: [Profile], likes: [Profile]) {
        self.invites = invites
        self.likes = likes
    }
}


