//
//  TestHelper.swift
//  MindValleyAssignmentTests
//
//  Created by Soham Ray on 19/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit
import MindValleyAssignment

final class TestHelper {
    
    var image: UIImage {
        return UIImage(named: "like")!
    }
    
    func imageResponseData() -> Data {
        return image.pngData()!
    }
    
}
