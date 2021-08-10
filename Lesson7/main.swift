//
//  main.swift
//  Lesson7
//
//  Created by Andrei Naumenko on 09.08.2021.
//

import Foundation


enum MatError: Error{
    
    case sideAerror (sideA: Int)
    case sideBerror (sideB: Int)

    var locDesription: String{
        switch self {
        case .sideAerror(sideA: let sideA):
            return "\(sideA), заданное значение не может быть больше или равно нулю"
        case .sideBerror(sideB: let sideВ):
            return "\(sideВ), заданное значение не может быть больше или равно нулю"
        }
    }
}

class Triangle{
    let sideA: Int
    let sideB: Int
    
    init(sideA: Int, sideB: Int) {
        self.sideA = sideA
        self.sideB = sideB
    }
    

    func triangleAreaWithError() -> (Int?, MatError?) {
        guard sideA > 0 else {
            return (nil, .sideAerror(sideA: sideA))
        }
        
        guard sideB > 0 else {
            return (nil, .sideBerror(sideB: sideB))
        }
        
        let area = (sideA * sideB) / 2
        return (area, nil)
        
    }


    func triangleArea() -> Result<Int, MatError> {
        guard sideA > 0 else {
            return .failure(.sideAerror(sideA: sideA))
        }
        
        guard sideB > 0 else {
            return .failure(.sideBerror(sideB: sideB))
        }
        
        let area = (sideA * sideB) / 2
        return .success(area)
        
    }
}

let tr1 = Triangle (sideA: 5, sideB: 5).triangleAreaWithError()

if let area = tr1.0 {
    print ("Площадь прямоугольного треугольника = \(area)")
} else if let error = tr1.1 {
    print ("Вы ввели не правильное значение \(error)")
}

let tr2 = Triangle (sideA: 0, sideB: 4).triangleArea()

switch tr2 {
case .success(let area):
    print ("Площадь прямоугольного треугольника = \(area)")
case .failure(let error):
    print ("Вы ввели не правильное значение \(error)")
}


//-------------------------------------


class Triangle2{
    let sideA: Int
    let sideB: Int
    
    init(sideA: Int, sideB: Int) {
        self.sideA = sideA
        self.sideB = sideB
    }

    func triangleArea () throws -> Int {
        guard sideA > 0 else {
            throw MatError.sideAerror(sideA: sideA)
        }
        
        guard sideB > 0 else {
            throw MatError.sideBerror(sideB: sideB)
        }
        
        return (sideA * sideB) / 2
        }
}

do {
    let tri1 = try Triangle2 (sideA: 7, sideB: 4).triangleArea()
    print("Площадь прямоугольного треугольника равна \(tri1)")
    
} catch MatError.sideAerror(sideA: let sideA) {
print("Вы ввели неверное значение: \(sideA), т.к. значение не может быть больше или равно 0 ")
} catch MatError.sideBerror(sideB: let sideB) {
print("Вы ввели неверное значение: \(sideB), т.к. значение не может быть больше или равно 0 ")

} catch let error {
    print(error)
}


