//
//  Constants.swift
//  Double Plan
//
//  Created by Prince Sojitra on 22/02/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import UIKit

enum Const {
    static let closeCellHeight: CGFloat = 70
    static let openCellHeight: CGFloat = 990
    static let rowsCount = Constants.arrayEventList.count
}


class Constants {
    
    //MARK: - GENERAL CONSTANT
    static let APPNAME = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
    static var MAINSTORYBOARD =  UIStoryboard(name: "Main", bundle: nil)
    static let arrayEventList = ["Morning","Noon","Afternoon","Evening","Night"];
}


//MARK: - StoryBoards & Identifiers
extension Constants {
    
    struct ViewControllerIdentifier {
        static let EventListVC =  "EventListVC"
    }
}


//MARK: - Colours
extension Constants {
    struct Colours {
        static let PrimaryBlue = UIColor.clear.HexStringToUIColor(hex: "#59D0DA")
    }
}

//MARK: - Strings & Messages
extension Constants {
    
    struct Strings {
        static let strEventListNavTitle = "My Plans"
    }
    
    struct Messages {
        static let NoInternet = "The internet connection appears to be offline"
        static let Error = "Something went wrong."
    }
    
}

//MARK: - TableViewCell Identifiers
extension Constants {
    struct TblCellIdentifier {
        static let EventList = "TblCell_EventList"
    }
}
