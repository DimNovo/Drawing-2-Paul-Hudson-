//
//  ContentView.swift
//  Drawing 2 { Paul Hudson }
//
//  Created by Dmitry Novosyolov on 07/11/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

//MARK: - Image Blur & Saturation effects + Button screen
struct ContentView: View {
    @State private var amount: CGFloat = 0.0
    @State private var trapezoidPresented = false
    var body: some View {
        VStack {
            Image("image")
            .resizable()
            .scaledToFit()
                .frame(width: 400, height: 400)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
            .padding()
            
            Button(action: { self.trapezoidPresented.toggle()}) { Text("Trapezoid Example").font(.title).shadow(color: .black, radius: 3)}
                .padding()
                .background(Color.init(.darkGray))
                .clipShape(Capsule())
                .shadow(color: .white, radius: 8)
                .offset(x: 0, y: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: self.$trapezoidPresented) { TrapezoidView()}
    }
}

//MARK: - Trapezoid
struct Trapezoid: Shape {
    var insetAmount: CGFloat
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}

//MARK: - Trapezoid View
struct TrapezoidView: View {
    @State private var insetAmount: CGFloat = 50
    var body: some View {
        NavigationView {
            Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
                .onTapGesture {
                    withAnimation { self.insetAmount = CGFloat.random(in: 10...90)}
            }
            .navigationBarTitle("\(String(format: "Inset Amount: %.2f", round(self.insetAmount)))", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
