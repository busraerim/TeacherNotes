//
//  Model.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 17.01.2024.
//

import Foundation

struct Schedule{
    var day:String
    var time: String
    var section : String
    var lesson : String
    var className: String
}

var sectionData:[Int] = []

struct GetDataSchedule{
    var startTime:String
    var endTime:String
    var section:String
    var lessonName:String
    var className:String
}

