//
//  ContentView.swift
//  clubSS
//
//  Created by Stjepan Stojčević on 10.08.2023..
//


import SwiftUI

class ClubsViewModel: ObservableObject {
    @Published var selectedCityIndex = 0
    @Published var selectedClubIndex = 0
    @Published var selectedSingerIndex = 0

    let clubsByCity: [String: [String]] = [
        "Biograd": ["Aqua", "Queen"],
        "Zadar": ["Ledana"],
        "Zagreb": ["Roko","Ritz","H2O"],
        "Požega": ["Platinum","Deja Vu"],
        "Bol": ["Auro"],
        "Makarska": ["Marakana"]
    ]

    var cities: [String] {
        Array(clubsByCity.keys)
    }

    var selectedCity: String {
        cities[selectedCityIndex]
    }

    var clubsInSelectedCity: [String] {
        clubsByCity[selectedCity] ?? []
    }

    var singers = ["Voyage","Nucci","Jala Brat","Buba Corelli","Fox","Grše","Sandra Afrika","Mile Kitić"]
}

struct ContentView: View {
    @StateObject private var viewModel = ClubsViewModel()
    @State private var isClubSelected = false
    @State private var isHelloWorldVisible = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $viewModel.selectedCityIndex, label: Text("City").foregroundColor(Color.red)) {
                        ForEach(viewModel.cities.indices, id: \.self) { index in
                            Text(viewModel.cities[index])
                        }
                    }
                }
                
                Section {
                    Picker(selection: $viewModel.selectedClubIndex, label: Text("Club").foregroundColor(Color.blue)) {
                        ForEach(viewModel.clubsInSelectedCity, id: \.self) { clubName in
                            Text(clubName)
                        }
                    }
                }
                
                Section {
                    Picker(selection: $viewModel.selectedSingerIndex, label: Text("Singer").foregroundColor(Color.orange)) {
                        ForEach(viewModel.singers.indices, id: \.self) { index in
                            Text(viewModel.singers[index])
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        isClubSelected.toggle()
                        isHelloWorldVisible.toggle()
                    }) {
                        Text("Show Details")
                    }
//if isClubSelected {
//                        Text("Selected Club: \(viewModel.clubsInSelectedCity[viewModel.selectedClubIndex])")
//                    }
                    
                    if isHelloWorldVisible {
                        Text("nedjalja 13.08")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .padding()
                        Text("cijena karte : 15€")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationTitle(Text("Partyyy...🥳"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
