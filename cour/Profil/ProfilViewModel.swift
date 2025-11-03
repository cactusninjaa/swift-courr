//
//  ProfilView.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI
import PhotosUI

@Observable
class ProvilViewModel {
    var firstName = "Leo"
    var lastName = "Riche"
    
    func updateLastName (newLastName: String){
        if (newLastName == "") {
            return
        }
        lastName = newLastName
    }
    func updateFirstName (newFristName: String){
        if newFristName == "" {
            return
        }
        firstName = newFristName
    }
}
