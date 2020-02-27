//
//  MainViewController.swift
//  Fitness
//
//  Created by Вячеслав on 25.02.2020.
//  Copyright © 2020 Вячеслав. All rights reserved.
//

import UIKit
import Alamofire
import FSCalendar

class MainViewController: UIViewController {
    let networkManager = NetworkManager()
    
    var responseSchedule = ResponseSchedule(cells: [])
    var schedules: [Schedule] = []
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFSCalendar()
        loadData()
    }
    
    private func setupFSCalendar(){
        calendar.dataSource = self
        calendar.delegate = self
        self.calendar.select(Date())
        self.calendar.scope = .week
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        title = "Schedule"
        let nib = UINib(nibName: "ScheduleCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ScheduleCell.reuseId)
    }
    
    private func loadData(){
        networkManager.fetchSchedule { (responseSchedule) in
            let currentDay = Calendar.current.component(.weekday, from: Date()) - 1
            if let responseSchedule = responseSchedule{
                self.responseSchedule = responseSchedule
            }
            self.returnScheduleForWeekDay(day: currentDay)
        }
    }
    
    private func returnScheduleForWeekDay(day: Int){
        schedules = responseSchedule.returnSchedule(for: day)
        self.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.reuseId, for: indexPath) as! ScheduleCell
        let viewModel = schedules[indexPath.row]
        cell.set(viewModel: viewModel)
        return cell
    }
}
extension MainViewController: FSCalendarDataSource, FSCalendarDelegate{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let weekDayNumber = Calendar.current.component(.weekday, from: date) - 1
        returnScheduleForWeekDay(day: weekDayNumber)
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
}
