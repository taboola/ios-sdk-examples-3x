//
//  ClassicMainViewController.swift
//  TaboolaSDKExampleSwift
//
//  Created by Tzufit Lifshitz on 16/11/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

import UIKit
import SwiftUI

class ClassicMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func openSwiftUI(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let swiftUIView = SwiftUIViews()
            let hostingController = UIHostingController(rootView: swiftUIView)
            self.show(hostingController, sender: nil)
        } else {
            let alert = UIAlertController(title: "SwiftUi", message: "SwiftUI is available from iOS13", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
