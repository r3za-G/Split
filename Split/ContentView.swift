//
//  ContentView.swift
//  Split
//
//  Created by Reza Gharooni on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount = 0.0
    @State private var people = 2
    @State private var serviceChargePercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let serviceChargePercentages = [0, 10, 15, 20, 25]
    
    
    var totalPerPerson: Double {
        let numberOfPeople = Double(people + 2)
        let serviceChargeSelection = Double(serviceChargePercentage)
        
        let serviceChargeValue = Double(billAmount / 100 * serviceChargeSelection)
        let totalBill = billAmount + serviceChargeValue
        let amountPerPerson = totalBill / numberOfPeople
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let serviceChargeSelection = Double(serviceChargePercentage)
        let serviceChargeValue = Double(billAmount / 100 * serviceChargeSelection)
        let totalBill = billAmount + serviceChargeValue
        return totalBill
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP")) .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Service Charge", selection: $serviceChargePercentage) {
                        ForEach(0..<101, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Service Charge")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                } header: {
                    Text("Total amount including service charge")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                } header: {
                    Text("Amount Per Person")
                }
                
            }
            .navigationTitle("Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
