//
//  RaceDateCalculatorView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/9/22.
//

import SwiftUI

struct RaceDateCalculatorView: View {
    
    @StateObject var vm = ViewModel()
    @FocusState private var keyboardIsFocus: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("Calculation Type") {
                    Text(vm.calcMode.explanation)
                        .padding()
                    Picker("Calculation Type", selection: $vm.calcMode) {
                        ForEach(DateCalculation.allCases, id: \.self) { calcType in
                            Text(calcType.description)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Input") {
                    switch(vm.calcMode) {
                    case .raceDate:
                        DatePicker("Start Date", selection: $vm.startDate, displayedComponents: [.date])
                        TextField("Training Block Length (weeks)", text: $vm.trainingBlockLength)
                            .keyboardType(.numberPad)
                            .focused($keyboardIsFocus)
                    case .startDate:
                        DatePicker("Race Date", selection: $vm.raceDate, displayedComponents: [.date])
                        TextField("Training Block Length (weeks)", text: $vm.trainingBlockLength)
                            .keyboardType(.numberPad)
                            .focused($keyboardIsFocus)
                    case .trainingBlockLength:
                        DatePicker("Start Date", selection: $vm.startDate, displayedComponents: [.date])
                        DatePicker("Race Date", selection: $vm.raceDate, displayedComponents: [.date])
                    }
                }
                Section("Output") {
                    Text(vm.result)
                }
                
            }
            .navigationTitle("Date Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("done") {
                        keyboardIsFocus = false
                    }
                }
            }
        }
    }
}

struct RaceDateCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RaceDateCalculatorView()            
        }
    }
}
