//
//  GlobalVariables.swift
//  macnivision
//
//  Created by Theresia Saputri on 28/06/22.
//

import Foundation

final class GlobalVariables: ObservableObject{
    
    static let global = GlobalVariables()
    
    @Published var userRecordId = ""
    
    @Published var userNickname = ""
    @Published var selectedPet = ""
    
    @Published var emotion = ""
    @Published var diary = ""
    @Published var notes = ""
    
    @Published var daysInMonth = 1
}
