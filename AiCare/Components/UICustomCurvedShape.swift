//
//  UI.swift
//  AiCare
//
//  Created by Alfan on 22/04/25.
//

import SwiftUI

struct UICustomCurvedShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            
            
            let mid = rect.width / 2
            
            path.move(to: CGPoint(x: mid - 60 , y: 0))
            
            let to1 = CGPoint(x: mid, y: 42)
            let control1 = CGPoint(x: mid - 35, y: 0)
            let control2 = CGPoint(x: mid - 35, y: 42)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: mid + 60, y: 0)
            let control3 = CGPoint(x: mid + 35, y: 42)
            let control4 = CGPoint(x: mid + 35, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

#Preview {
    BaseView()
}
