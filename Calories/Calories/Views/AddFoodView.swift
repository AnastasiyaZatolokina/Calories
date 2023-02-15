//
//  AddFoodView.swift
//  Calories
//
//  Created by Анастасия Затолокина on 10/2/23.
//

import SwiftUI

struct addFoodView: View {
    @Environment (\.managedObjectContext) var manageObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, calories: calories, context: manageObjContext)
                        dismiss()
                    }
                    Spacer()
                    
                }
            }
        }
    }
}
