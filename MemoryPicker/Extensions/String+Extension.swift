//
//  String+Extension.swift
//  MemoryPicker
//
//  Created by Denis Feier on 18.08.2025.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
