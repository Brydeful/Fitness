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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(viewModel: Schedule){
        nameLabel.text = viewModel.name
        startTimeLabel.text = viewModel.startTime
        endTimeLabel.text = viewModel.endTime
//        let teacher = viewModel.teacher.components(separatedBy: " ")[1]
//        teacherLabel.text = teacher
        teacherLabel.text = viewModel.teacher
        
        placeLabel.text = viewModel.place
    }
    
}
