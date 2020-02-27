//
//  Schedule.swift
//  Fitness
//
//  Created by Вячеслав on 25.02.2020.
//  Copyright © 2020 Вячеслав. All rights reserved.
//

import UIKit

struct Schedule: Codable{
    let name: String
    let startTime: String
    let endTime: String
    let teacher: String
    let place: String
    let description: String
    let weekDay: Int
}

struct ResponseSchedule{
    let cells: [Schedule]

    func returnSchedule(for weekkDay: Int) ->[Schedule]{
        let scheduleInDay = cells.filter{$0.weekDay == weekkDay}
        return scheduleInDay
    }
}
