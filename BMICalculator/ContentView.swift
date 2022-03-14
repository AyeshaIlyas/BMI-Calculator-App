//
//  ContentView.swift
//  BMICalculator
//
//  Created by Ayesha Ilyas on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var weight = "";
    @State private var height = "";
    @State private var BMI = "Unknown";
    @State private var category = "Unknown";
    @State private var showError = false;
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("BMI Calculator App")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack(alignment: .center)  {
                HStack {
                    Spacer()
                    Text("Weight (lbs): ")
                    TextField("Enter weight in lbs", text: $weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 300.0)
                    Spacer()
                }
                .padding()
            
                HStack {
                    Spacer()
                    Text("Height (in): ")
                    TextField("Enter height in inches", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 300.0)
                    Spacer()
                }
                .padding()
                
                HStack {
                    if (showError) {
                        Image(systemName:"exclamationmark.triangle.fill")
                        Text("Please enter a valid weight and height")
                    }
                }
                .padding(.top)
                .foregroundColor(Color.red)
            }

                        
            Spacer()
            
            Button("Calculate BMI") {
                // get weight and height and set to zero if weight or height are not valid Doubles
                let weightDouble = Double(weight) ?? 0.0
                let heightDouble = Double(height) ?? 0.0
                // if inputs not valid, show error message, reset results, and do not do any calculations
                if (weightDouble <= 0.0 || heightDouble <= 0.0) {
                    showError = true
                    BMI = "Unknown"
                    category = "Unknown"
                }
                // calculate BMI and display results
                else {
                    showError = false
                    let BMIValue = calculateBMI(weight: weightDouble, height: heightDouble)
                    BMI = String(round(BMIValue * 10.0) / 10.0)
                    category = getBMICategory(BMI: BMIValue)
                }
            }
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .font(.title3)
            .cornerRadius(10.0)
            
            Spacer()
            
            Text("Body Mass Index (BMI): \(BMI)")
            Text("BMI Category: \(category)")
            
            Spacer()
            
        }
    }
    
    func calculateBMI(weight: Double, height: Double) -> Double {
        return weight / pow(height, 2) * 703.0
    }
    
    func getBMICategory(BMI: Double) -> String {
    
        if BMI < 18.5 {
            return "Underweight"
        } else if BMI >= 18.5 && BMI < 25 {
            return "Healthy"
        } else if BMI >= 25 && BMI < 30 {
            return "Overweight"
        } else { // >= 30
            return "Obese"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone SE (2nd generation)")
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
