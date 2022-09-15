//
//  String.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 15/09/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
