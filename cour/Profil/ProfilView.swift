//
//  ProfilModel.swift
//  cour
//
//  Created by thomas sauvage on 03/11/2025.
//

import SwiftUI
import PhotosUI

struct ProfilView: View {
    @State var profilViewModel = ProvilViewModel()
    @State private var newFristName = ""
    @State private var newLastName = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?

    var body: some View{
        NavigationStack(){
            HStack(){
                if let image = image {
                    image
                       .resizable()
                       .scaledToFit()
                       .frame(height: 100)
                       .clipShape(Circle())
               } else {
                   Image(systemName: "person.crop.circle.fill")
                       .resizable()
                       .scaledToFit()
                       .frame(height: 100)
                       .clipShape(Circle())
               }
                Spacer()
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    Image(systemName: "pencil")
                }
                .padding(.bottom)
                .onChange(of: selectedPhoto) { _, _ in
                    Task {
                        if let loadedImage = try? await selectedPhoto?.loadTransferable(type: Image.self){
                            image = loadedImage
                        } else {
                            print("Failed to load image")
                        }
                    }
                }
            }
            HStack(){
                TextField(
                    "New first name",
                    text: $newFristName
                ) .textFieldStyle(.roundedBorder)
                TextField(
                    "New last name",
                    text: $newLastName
                ) .textFieldStyle(.roundedBorder)
                Button("Modifier"){
                    profilViewModel.updateFirstName(newFristName: newFristName)
                    profilViewModel.updateLastName(newLastName: newLastName)
                }
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
            HStack(){
                Text(profilViewModel.firstName)
                    .font(.title)
                    .bold()
                Text(profilViewModel.lastName)
                    .font(.title)
                    .bold()
            }
            Spacer()
            ScrollView() {
                ForEach(
                   1...10,
                   id: \.self
                ) {_ in
                   Image("coucou")
                       .resizable()
                       .scaledToFit()
                       .frame(height: 400)
               }
            }
        }
        .padding()
    }
}

#Preview {
    ProfilView()
}
