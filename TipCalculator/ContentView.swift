//
//  ContentView.swift
//  TipCalculator
//
//  Created by Yuichiro Kinoshita on 2024/06/05.
//

import SwiftUI

struct ContentView: View {
    @State private var totalAmount: String = ""
    @State private var tipPercentage: Double = 15
    @State private var exchangeRate: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("チップ計算").font(.title2).foregroundColor(.accentColor)) {
                    HStack {
                        Text("請求金額")
                            .font(.title2)
                        Spacer()
                        TextField("請求金額を入力", text: $totalAmount)
                            .keyboardType(.decimalPad)
                            .font(.title2)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: 150)
                    }
                    
                    Slider(value: $tipPercentage, in: 10...30, step: 1)
                    
                    HStack {
                        Text("チップ率")
                            .font(.title2)
                        Spacer()
                        Text("\(Int(tipPercentage))%")
                            .font(.title2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: 50)
                    }
                    
                    HStack {
                        Text("チップ金額")
                            .font(.title2)
                        Spacer()
                        Text("\(calculateTip(), specifier: "%.2f")")
                            .font(.title2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("合計金額")
                            .font(.title2)
                        Spacer()
                        Text("\(calculateTotal(), specifier: "%.2f")")
                            .font(.title2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("日本円換算").font(.title2).foregroundColor(.accentColor)) {
                    HStack {
                        Text("為替レート")
                            .font(.title2)
                        Spacer()
                        TextField("レートを入力", text: $exchangeRate)
                            .keyboardType(.decimalPad)
                            .font(.title2)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: 150)
                    }
                    
                    HStack {
                        Text("円換算額")
                            .font(.title2)
                        Spacer()
                        Text("\(Int(calculateInYen()))円")
                            .font(.title2)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationBarTitle("TipCalculator")
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    func calculateTip() -> Double {
        let amount = Double(totalAmount) ?? 0
        return amount * tipPercentage / 100
    }
    
    func calculateTotal() -> Double {
        let amount = Double(totalAmount) ?? 0
        return amount + calculateTip()
    }
    
    func calculateInYen() -> Double {
        let rate = Double(exchangeRate) ?? 0
        return calculateTotal() * rate
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    ContentView()
}




