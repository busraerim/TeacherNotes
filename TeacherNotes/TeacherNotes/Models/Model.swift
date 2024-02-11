//
//  Model.swift
//  TeacherNotes
//
//  Created by Büşra Erim on 11.01.2024.
//

import Foundation

struct homePage{
    var title:String
    var image:String
}


enum UserRoles:String{
    case teacher = "Öğretmen"
    case student = "Öğrenci"
    case parent = "Veli"
    
    var homePages:[homePage]{
        switch self {
        case .teacher:
            return [homePage(title: "Ders Programım", image: "Schedule"),
                    homePage(title: "Sınıflar", image: "Class"),
                    homePage(title: "Öğrenciler", image: "Students"),
                    homePage(title: "Değerlendirme Raporu", image: "assessment"),
                    homePage(title: "Ödevler", image: "Homework")]
        case .student:
            return [homePage(title: "Ders Programım", image: "Schedule"),
                    homePage(title: "Sınıflar", image: "Class"),
                    homePage(title: "Ödevler", image: "Homework")]
        case .parent:
            return [homePage(title: "Ders Programı", image: "Schedule"),
                    homePage(title: "Sınıflar", image: "Class"),
                    homePage(title: "Ödevler", image: "Homework"),
                    homePage(title: "Öğretmenler", image: "Students")]
        }
    }
}
