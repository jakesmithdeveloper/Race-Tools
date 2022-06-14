//
//  PaceCalculatorView.swift
//  RaceTools
//
//  Created by Jake Smith on 5/5/22.
//

import SwiftUI

struct PaceCalculatorView: View {
        
    @StateObject private var vm: ViewModel = ViewModel()
    @FocusState private var distanceIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section("calculation") {
                    if vm.calculationType == .pace {
                        Text("Calculate your goal pace based off of goal finish.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                    } else {
                        Text("Calculate finish time based off of average pace.")
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                    }
                    Picker("Calculation Type", selection: $vm.calculationType) {
                        ForEach(CalcType.allCases, id: \.self) { calcType in
                            Text(calcType.description)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: vm.calculationType) { newValue in
                        vm.clearInputs()
                    }
                }
                
                Section("distance input") {
                    TextField("Enter Distance", text: $vm.distanceInput)
                        .keyboardType(.decimalPad)
                        .focused($distanceIsFocused)
                    Picker("distance type", selection: $vm.inputDistanceType) {
                        ForEach(vm.distanceTypes, id: \.self) {
                            Text("\($0)s")
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack() {
                        Spacer()
                        Text("\(vm.calculationType == .pace ? "finish:" : "pace:")")
                        Group {
                            ContentWidthTextField(textInput: $vm.hoursInput, title: "hours")
                              .focused($distanceIsFocused)
                            Text(":")
                            ContentWidthTextField(textInput: $vm.minutesInput, title: "minutes")
                              .focused($distanceIsFocused)
                            Text(":")
                            ContentWidthTextField(textInput: $vm.secondsInput, title: "seconds")
                              .focused($distanceIsFocused)
                        }
                        .keyboardType(.numberPad)
                        if vm.calculationType == .finish {
                            Text("\(vm.outputDistanceType == "mile" ? "/m" : "/km")")
                        }
                        Spacer()
                    }
                    if vm.calculationType == .finish {
                        Picker("distance type", selection: $vm.outputDistanceType) {
                            ForEach(vm.distanceTypes, id: \.self) {
                                Text("\($0)s")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    HStack {
                        Spacer()
                        Button("clear inputs") {
                            vm.clearInputs()
                        }
                        Spacer()
                    }
                }
                
                Section("output") {
                    if vm.calculationType == .finish {
                        Text("\(vm.result != "" ? vm.result : "")")
                    } else {
                        Text(vm.result != "" ? "\(vm.result) / \(vm.outputDistanceType)" : "")
                        if vm.calculationType == .pace {
                            Picker("output type", selection: $vm.outputDistanceType) {
                                ForEach(vm.distanceTypes, id: \.self) {
                                    Text("\($0)s")
                                }
                            }
                            .pickerStyle(.segmented)
                        }                        
                    }
                }
            }
            .navigationTitle("Pace Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("done") {
                        distanceIsFocused = false
                        vm.validate()
                    }
                }
            }
        }
    }
}

struct PaceCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PaceCalculatorView()
        }
    }
}
