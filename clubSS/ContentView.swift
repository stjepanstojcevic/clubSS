//
//  ContentView.swift
//  clubSS
//
//  Created by Stjepan Stojčević on 10.08.2023..
//

import SwiftUI

struct ContentView: View {
    @State private var clubIndex = 0
    @State private var cityIndex = 0
    @State private var singerIndex = 0
    var clubs = ["Aqua","Ledana","Q","Deja vu","Queen","Platinum"]
    var cities = ["Biograd","Zadar","Zagreb","Požega"]
    var singers = ["Voyage","Nucci","Jala Brat","Buba Corelli","Fox","Grše","Sandra Afrika"]
    
    var body: some View
    {
        NavigationView
        {
            Form
            {
                Section
                {
                    Picker(selection: $cityIndex, label: Text("City")
                        .foregroundColor(Color.red))
                    {
                        ForEach(cities.indices, id: \.self)
                        {
                            Text(self.cities[$0])
                        }
                    }
                }
                Section
                {
                    Picker(selection: $clubIndex, label: Text("Club")
                        .foregroundColor(Color.blue))
                    {
                        ForEach(clubs.indices, id: \.self)
                        {
                            Text(self.clubs[$0])
                        }
                    }
                }
                
                Section
                {
                    Picker(selection: $singerIndex, label: Text("Singer")
                        .foregroundColor(Color.orange))
                    {
                        ForEach(singers.indices, id: \.self)
                        {
                            Text(self.singers[$0])
                        }
                    }
                }
            }.navigationTitle(Text("Partyyy...🥳"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

