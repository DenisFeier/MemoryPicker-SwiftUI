//
//  LoginBackground.swift
//  MemoryPicker
//
//  Created by Denis Feier on 16.08.2025.
//

import SwiftUI

struct LoginBackground: View {
    var body: some View {
        Color.clear.background(
            Image("backgroundImg").resizable().scaledToFill()
        ).ignoresSafeArea()
    }
}
