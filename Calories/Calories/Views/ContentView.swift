//
//  ContentView.swift
//  Calories
//
//  Created by Анастасия Затолокина on 10/2/23.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
        
    @State private var showingAddView = false
    @State private var selectedTab: Tab = .magazine
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) KCal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            
                        }
                    }
                }
                VStack {
                    
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)

                }
                
                
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.black)
                                }
                                Spacer()
                                
                                Text(calcTimeSince(date:food.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            
            }
            .navigationBarTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                addFoodView()
            }
           
        }
        .navigationViewStyle(.stack)
    
    }
        private func deleteFood(offsets: IndexSet) {
            withAnimation {
                offsets.map { food[$0] }.forEach(managedObjContext.delete)
                
                DataController().save(context: managedObjContext)
            }
        }
        
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        
        return caloriesToday
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
