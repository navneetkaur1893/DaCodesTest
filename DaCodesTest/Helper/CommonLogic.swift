//
//  CommonLogic.swift
//  DaCodesTest
//
//  Created by Navneet Kaur on 11/9/20.
//

import UIKit

class CommonLogic {
    static func returnHeaderView(_ height: CGFloat, _ width: CGFloat, _ title: String) -> UIView {
        let returnedView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: Double(width), height: Double(height)))
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: Double(width - 20), height: Double(height)))
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = title
        label.accessibilityIdentifier = "headerTitle"
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    static func changeDateFormat(into: DateFormatTypes, dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = into.rawValue
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return dateString
        }
    }
}
