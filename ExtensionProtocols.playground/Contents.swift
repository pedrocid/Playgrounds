//: Playground - noun: a place where people can play

import UIKit


protocol Representable{
    
    var name: String { get set }
    
}

class Person: Representable{

    var name: String
    
    init(name: String){
    
        self.name = name
    }
}

class Animal: Representable{
    
    var name: String
    
    init(name: String){
        
        self.name = name
    }
}

extension Representable{
    
    func show() -> String{
        
        return "I'm a '\(name.capitalizedString)"
        
    }
}


var representable: Representable

representable = Person(name: "pedro")

print(representable.show())

representable = Animal(name: "a lion")

print(representable.show())

