//
//  LoremText.swift
//  SwiftUIExample
//
//  Created by Tzufit Lifshitz on 09/08/2020.
//  Copyright © 2020 Tzufit Lifshitz. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct LoremText: View {
    var body: some View {
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
    }
}

@available(iOS 13.0, *)
struct LoremText_Previews: PreviewProvider {
    static var previews: some View {
        LoremText()
    }
}
