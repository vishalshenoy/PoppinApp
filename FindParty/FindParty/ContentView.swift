//
//  ContentView.swift
//  FindParty (built for Poppin)
//
//  Created by Vishal Shenoy on 5/28/23.
//

import SwiftUI

struct Party: Identifiable {
    let id = UUID()
    let name: String
    let imageURL: String
    let price: Double
    let amountGoing: Int
    let startDate: Date
    let endDate: Date?
}

let sampleParties = [
    Party(name: "Poppin Party", imageURL: "party1", price: 5.00, amountGoing: 20, startDate: Date(), endDate: nil),
    Party(name: "Global Gala", imageURL: "party2", price: 2.00, amountGoing: 200, startDate: Date(), endDate: Date()),
    Party(name: "Kool Kickback", imageURL: "party3", price: 9.00, amountGoing: 3, startDate: Date(), endDate: nil)
]

struct ContentView: View {
    @State private var searchQuery = ""
    @State private var parties: [Party] = sampleParties
    
    var filteredParties: [Party] {
        if searchQuery.isEmpty {
            return parties
        } else {
            return parties.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Party Finder")
                        .padding(.top, 10)
                        .font(.custom(
                            "Arial Rounded MT Bold",
                            fixedSize: 36))
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search parties", text: $searchQuery)
                            .padding(.leading, 5)
                            .foregroundColor(.black)
                            .colorInvert()
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(0)
                    
                    List(filteredParties) { party in
                        PartyCardView(party: party)
                            .listRowBackground(Color.black.opacity(0.9))
                    }
                    .listStyle(InsetGroupedListStyle())
                    .background(Color.black)
                    
                    Button(action: addRandomParty) {
                        Text("Add Party")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .font(.custom(
                                "Arial Rounded MT Bold",
                                fixedSize: 16))
                    }
                    .background(Color.black)
                    .foregroundColor(.white)
                }
                .background(Color.black)
                .foregroundColor(.white)
            }
            .background(Color.black)
            .foregroundColor(.white)
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
    
    func addRandomParty() {
        
        let randomName = generateRandomName()
        let randomImageURL = generateRandomImageURL()
        let randomPrice = generateRandomPrice()
        let randomPeople = generateRandomPeople()
        let randomStartDate = generateRandomDate()
        let randomEndDate = Bool.random() ? randomStartDate.addingTimeInterval(Double.random(in: 1...11) * 24 * 60 * 60) : nil
        
        let newParty = Party(name: randomName, imageURL: randomImageURL, price: randomPrice, amountGoing: Int(randomPeople), startDate: randomStartDate, endDate: randomEndDate)
        
        parties.append(newParty)
    }
    
    func generateRandomName() -> String {
        let names = ["Fortnite Fiesta", "Frat Frenzy", "Birthday Bash", "Krazy Kickback", "Poppin Party", "Gentlemen Gala", "Amongus Affair", "Boat Ball", "Kool Kickback", "Fun Fiesta", "Drinking Derby", "Awesome Party", "Gross Gathering", "Cool Concert"]
        return names[Int.random(in: 0...13)]
    }
    
    func generateRandomImageURL() -> String {
        let names = ["party1", "party2", "party3", "party4", "party5", "party6", "party7"]
        return names[Int.random(in: 0...6)]
    }
    
    func generateRandomPrice() -> Double {
        return Double.random(in: 0..<10)
    }
    
    func generateRandomDate() -> Date {
        return Date().addingTimeInterval(Double.random(in: 0..<11 * 24 * 60 * 60))
    }
    func generateRandomPeople() -> Double {
        return  Double.random(in: 0..<200)
    }
}


struct PartyCardView: View {
    let party: Party
    var body: some View {
        VStack {
            Text(party.name)
                .font(.custom( "Arial Rounded MT Bold", fixedSize: 27))
                .padding()
            
            Image(party.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            
            Text("Price: $\(String(format: "%.2f", party.price))")
                .padding(.top)
                .font(.custom( "Arial Rounded MT Bold", fixedSize: 20))
            
            Text("Attendees: \(party.amountGoing)")                         .font(.custom( "Arial Rounded MT Bold", fixedSize: 15))
            
            
            if let endDate = party.endDate {
                Text("Start Date: \(formatDate(party.startDate))")
                    .font(.custom( "Arial Rounded MT Bold", fixedSize: 15))
                Text("End Date: \(formatDate(endDate))")
                    .font(.custom( "Arial Rounded MT Bold", fixedSize: 15))
            } else {
                Text("Start Date: \(formatDate(party.startDate))")
                    .font(.custom( "Arial Rounded MT Bold", fixedSize: 15))
            }
        }
        .padding()
        .background(Color.black.opacity(0.9))
        .cornerRadius(10)
        .padding()
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
