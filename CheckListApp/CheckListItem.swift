//
//  CheckListItem.swift
//  CheckListApp
//
//  Created by user on 27.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class CheckListItem: NSObject {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
