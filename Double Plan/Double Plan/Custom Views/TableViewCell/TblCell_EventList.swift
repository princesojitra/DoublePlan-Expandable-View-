//
//  TblCell_EventList.swift
//  Double Plan
//
//  Created by Prince Sojitra on 22/02/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import FoldingCell
import UIKit

protocol TblCell_EventListDelegate {
    func acceptEventButtonTapped(cell: TblCell_EventList)
}

class TblCell_EventList: FoldingCell {
    
    //MARK: - @IBOutlet
    @IBOutlet var lblCloseTime: UILabel!
    @IBOutlet var lblOpenTime: UILabel!
    @IBOutlet var btnAcceptEvent: UIButton!
    @IBOutlet var btnDeclineEvent: UIButton!
    
    //MARK: - Variable
    var delegate: TblCell_EventListDelegate?
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        // Add action to perform when the button is tapped
          self.btnAcceptEvent.addTarget(self, action: #selector(acceptEventButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Handle Tap on accept event
    @IBAction func acceptEventButtonTapped(_ sender: UIButton){
        self.delegate?.acceptEventButtonTapped(cell: self)
    }
    
}
