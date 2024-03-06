//
//  Model.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 17.01.2024.
//

import Foundation

struct Schedule{
    var day:String //gün kontrol
    var time: String // başlama bitme
    var section : String // kaçıncı ders
    var lesson : String // ders adı
    var className: String // sınıf
}

var sectionData:[Int] = []

struct GetDataSchedule{
    var startTime:String
    var endTime:String
    var section:String
    var lessonName:String
    var className:String
}

