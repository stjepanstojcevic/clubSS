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
    
    struct Performance {
        var singerName: String
        var clubName: String
        var performanceDate: Date
        var description: String
    }
     
    let nucciPerformance = Performance(
        singerName: "Nucci",
        clubName: "Aqua",
        performanceDate: DateComponents(calendar: .current, year: 2023, month: 7, day: 10).date!,
        description: "Karta je 15 eura"
    )

    let clubsByCity: [String: [String]] = [
        "Biograd": ["Any...","Aqua", "Queen","Pocco Locco"],
        "Zadar": ["Any...","Ledana"],
        "Zagreb": ["Any...","Roko","Ritz","H2O"],
        "Požega": ["Any...","Platinum","Deja Vu"],
        "Bol": ["Any...","Auro"],
        "Makarska": ["Any...","Marakana"]
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

    var singers = ["Any...","Voyage","Nucci","Jala Brat","Buba Corelli","Fox","Grše","Sandra Afrika","Mile Kitić","Severina","Henny","Popov","Aleksandra Prijović","Teodora Džehverović","Teodora Popovska","Ema Radujko","Maya Berović","Inas","Sajfer","Devito","Crni Cerak","Ivan Zak","Aca Lukas","Relja","Nikolija","Breskvica"] 
}

struct ContentView: View {
    @StateObject private var viewModel = ClubsViewModel()
    @State private var isClubSelected = false
    @State private var isDescribeVisible = false
    
    @State private var selectedSinger: String = ""
    @State private var selectedClub: String = ""
    @State private var selectedDate: Date = Date()

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
                        ForEach(0..<viewModel.clubsInSelectedCity.count, id: \.self) { index in
                            Text(viewModel.clubsInSelectedCity[index])
                                .tag(index)
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
                        isDescribeVisible.toggle()

                        selectedSinger = viewModel.singers[viewModel.selectedSingerIndex]
                        selectedClub = viewModel.clubsInSelectedCity[viewModel.selectedClubIndex]
                        selectedDate = viewModel.nucciPerformance.performanceDate
                    }) {
                        Text("Look what we found")
                    }
                    if isDescribeVisible {
                        Text(selectedSinger)
                            .foregroundColor(.red)
                            .padding()
                        Text("Club: \(selectedClub)")
                            .foregroundColor(.red)
                            .padding()
                        Text("Date: \(selectedDate, formatter: dateFormatter)")
                            .foregroundColor(.red)
                            .padding()
                        Text(viewModel.nucciPerformance.description)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .navigationTitle(Text("Partyyy...🥳🥳🥳"))
        }
    }
    
    // Date formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
