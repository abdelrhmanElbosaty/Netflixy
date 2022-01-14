//
//  TableView+Extenssion.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 10/01/2022.
//

import Foundation
import UIKit

extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
