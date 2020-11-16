//
//  TaboolaView.swift
//  GymRegistration
//
//  Created by Tzufit Lifshitz on 5/25/20.
//  Copyright © 2020 Taboola. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)

import TaboolaSDK
import SwiftUI

@available(iOS 13.0, *)
struct TBLClassicUnitSwiftUI: UIViewRepresentable {
    
    let page: TBLClassicPageSwift
    let placement: String
    let mode: String
    @Binding var height: CGFloat
    
 
    func makeUIView(context: Context) -> TBLClassicUnit {
        print("Body computed for number = \(placement)")
        let classicUnit = page.page.createUnit(withPlacementName: placement, mode: mode)
        page.pageDelegates.append(context.coordinator)
        classicUnit.fetchContent()
        return classicUnit
    }
    
    func updateUIView(_ uiView: TBLClassicUnit, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

@available(iOS 13.0, *)
class Coordinator: NSObject, TBLClassicPageSwiftDelegate {
    
    var parent: TBLClassicUnitSwiftUI
 
    init(_ parent: TBLClassicUnitSwiftUI) {
        self.parent = parent
    }
    
    func didLoadWithHeight(height: CGFloat) {
        self.parent.$height.wrappedValue = height
    }

}

#endif
