//: Playground - noun: a place where people can play

import UIKit

//MARK: TYPE VARIANCE LESSON

//First we explore supertypes and subtypes

class Thing {}
class Vehicle: Thing {}
class Car: Vehicle {}

var vehicle: Vehicle = Vehicle()
var car: Car = Car()

//Works

vehicle = Car()

//Doesn't work

//---> car = Vehicle()


//Functions

//This is a key rule: function return values can changed to subtypes, moving down the hierarchy, whereas function parameters can be changed to supertypes, moving up the hierarchy.


func getVehicle() -> Vehicle { return Vehicle() }
func getCar() -> Car { return Car() }

func driveThing(thing: Thing){}
func driveVehicle(vehicle: Vehicle) {}
func driveCar(car: Car) {}

var varDriveVehicle: (Vehicle) -> Void
var varDriveCar: (Car) -> Void

var varGetCar: () -> Car
var varGetVehicle: () -> Vehicle



//Works: Covariance works for subtypes in returned functions

varGetVehicle = getCar

//Doesn`t Work: Parameters are contravariants. Only accepts supertypes

//--> varDriveVehicle = driveCar

//Works: Contravariant

varDriveVehicle = driveThing


//Properties

//Read-only properties are pretty simple. Subclass properties must be subtypes. A read-only property is essentially a function which takes no parameters and returns a value, and the same rules apply.

class SuperPropertyType {}
class SubPropertyType: SuperPropertyType {}

class SuperClass {
    
    var superProperty: SuperPropertyType { get { return SuperPropertyType() }}
}

class Subclass: SuperClass {
    
    override var superProperty: SubPropertyType { get { return SubPropertyType() }}
}


//Generics

//For two generic types to be compatible in Swift, they must have identical generic parameters. Subtypes and supertypes are never allowed, even when the theory says it would be acceptable.


class SomeType<A> {}

//Not allowed because for swift A == B always
//--> class SomeType<B> {}

