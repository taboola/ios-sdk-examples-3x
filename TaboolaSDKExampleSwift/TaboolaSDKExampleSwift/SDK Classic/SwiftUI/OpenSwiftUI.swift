//
//  OpenSwiftUI.swift
//  QAApp
//
//  Created by Tzufit Lifshitz on 12/10/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import UIKit
import SwiftUI

class OpenSwiftUI: NSObject {
    
    @objc func openSwiftUI(vc:UIViewController) {
        if #available(iOS 13.0, *) {
            let swiftUIView = SwiftUIViews()
            let hostingController = UIHostingController(rootView: swiftUIView)
            vc.show(hostingController, sender: nil)
        } else {
            let alert = UIAlertController(title: "SwiftUi", message: "SwiftUI is available from iOS13", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
        
    }

}
