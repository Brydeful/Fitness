//
//  ScheduleCell.swift
//  Fitness
//
//  Created by Вячеслав on 25.02.2020.
//  Copyright © 2020 Вячеслав. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let reuseId = "cellId"

    func set(viewModel: Schedule){
        nameLabel.text = viewModel.name
        startTimeLabel.text = viewModel.startTime
        endTimeLabel.text = viewModel.endTime
        teacherLabel.text = viewModel.teacher
        
        placeLabel.text = viewModel.place
    }
    
}
