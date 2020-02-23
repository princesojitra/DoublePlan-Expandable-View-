//
//  EventListVC.swift
//  Double Plan
//
//  Created by Prince Sojitra on 22/02/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//



import UIKit
import FoldingCell
import FSCalendar

class EventListVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet var tblEventList: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Variable
    private let refreshControl = UIRefreshControl()
    var cellHeights: [CGFloat] = []
    let arrayEventList  = Constants.arrayEventList;
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d, MMMM yyyy"
        return formatter
    }()
    
}

//MARK: - UIViewController Life Cycle
extension EventListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fnDefaultSetUp()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UIViewController Actions & Events
extension EventListVC {
    
    //Refresh data on pull to refresh
    @objc private func refreshData(_ sender: Any) {
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tblEventList.refreshControl?.endRefreshing()
            }
            self?.tblEventList.reloadData()
        })
    }
}



// MARK: - UIViewController Others
extension EventListVC {
    
    //Default setup fot the view
    func fnDefaultSetUp(){
        self.navigationItem.title = Constants.Strings.strEventListNavTitle
        self.setTableView()
        self.setCalenderView()
    }
    
    
    //Setup Tableview UI
    func setTableView(){
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tblEventList.estimatedRowHeight = Const.closeCellHeight
        tblEventList.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 10.0, *) {
            tblEventList.refreshControl = refreshControl
        } else {
            
            tblEventList.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    //Setup Calender UI
    func setCalenderView(){
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        self.calendar.select(Date())
        self.calendar.scope = .week
        self.calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        self.calendar.firstWeekday = 3
        self.lblCurrentDate.text = self.dateFormatter.string(from: self.calendar?.selectedDate ?? Date())
    }
}


//MARK: - UITableView Datasource & Delegate
extension EventListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEventList.count
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as TblCell_EventList = cell else {
            return
        }
        cell.lblOpenTime.text = self.arrayEventList[indexPath.row]
        cell.lblCloseTime.text = self.arrayEventList[indexPath.row]
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight{
            cell.unfold(false, animated: false, completion: nil)
            
        } else {
            cell.unfold(true, animated: false, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellEventList = tableView.dequeueReusableCell(withIdentifier: Constants.TblCellIdentifier.EventList, for: indexPath) as! TblCell_EventList
        cellEventList.tag = indexPath.row
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cellEventList.durationsForExpandedState = durations
        cellEventList.durationsForCollapsedState = durations
        cellEventList.delegate = self
        
        return cellEventList
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
}

extension EventListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        
        //collapsed/expand state managed
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
    
}
//MARK: - EventList Tablel Cell Delegate
extension EventListVC : TblCell_EventListDelegate {
    
    func acceptEventButtonTapped(cell: TblCell_EventList) {
        print("tapped");
        cell.btnDeclineEvent.isHidden = true
        cell.btnAcceptEvent.backgroundColor = UIColor.clear
        cell.btnAcceptEvent.layer.borderWidth = 2.0
        cell.btnAcceptEvent.layer.cornerRadius = 10.0
        cell.btnAcceptEvent.layer.borderColor = UIColor.green.cgColor
        cell.btnAcceptEvent.setTitle("Accepted", for: .normal)
        cell.btnAcceptEvent.setTitleColor(UIColor.green, for: .normal)
        self.tblEventList.reloadData()
    }
}

//MARK: - Calender Datasource & Delegate
extension EventListVC : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    //calendar date changed notifier
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        self.lblCurrentDate.text = self.dateFormatter.string(from: self.calendar?.selectedDate ?? Date())
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    //calendar page changed notifier
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
        self.setFirstWeekDayOnWeekChange();
    }
    
    //set weekday as last selected day on week change
    func setFirstWeekDayOnWeekChange(){
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: self.calendar?.selectedDate ?? Date())
        self.calendar.firstWeekday = UInt(weekday)
    }
}
