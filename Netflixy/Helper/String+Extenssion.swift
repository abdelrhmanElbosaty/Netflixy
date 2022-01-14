//
//  String+Extenssion.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 06/01/2022.
//

import Foundation

extension String{
    func capitalizeFirstDigit() -> String{
        return String(self.prefix(1).uppercased() + self.lowercased().dropFirst())
    }
}
