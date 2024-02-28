//
//  Colors.swift
//  TeacherNotes
//
//  Created by BusraErim on 28.02.2024.
//

import Foundation
import UIKit

enum AppColor {
    case color1
    case color2
    case color3
    case color4
    
    var appColor: UIColor?{
        switch self {
        case .color1:
            return UIColor(red: 1.00, green: 0.95, blue: 0.85, alpha: 1.00)
        case .color2:
            return UIColor(red: 0.92, green: 0.84, blue: 0.73, alpha: 1.00)
        case .color3:
            return UIColor(red: 0.74, green: 0.64, blue: 0.50, alpha: 1.00)
        case .color4:
            return UIColor(red: 0.43, green: 0.16, blue: 0.20, alpha: 1.00)
        }
    }
}
