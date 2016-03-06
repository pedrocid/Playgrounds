//: Playground - noun: a place where people can play

import UIKit


//MARK: Construction Builder pattern

struct ObjectToConstruct {
    
    let propertyOne: String?
    let propertyTwo: Array<String>?
    let propertyThree: Bool?
    
}


class ConstructBuilder {
    
    private var propertyOne: String = ""
    private var propertyTwo: Array<String> = []
    private var propertyThree: Bool = false
    
    func withPropertyOne(propertyOne: String) -> ConstructBuilder{
    
        self.propertyOne = propertyOne
        return self
        
    }
    
    func withPropertyTwo(propertyTwo: Array<String>) -> ConstructBuilder{
        
        self.propertyTwo = propertyTwo
        return self
        
    }
    
    func withPropertyThree(propertyThree: Bool) -> ConstructBuilder{
        
        self.propertyThree = propertyThree
        return self
        
    }
    
    func build() -> ObjectToConstruct {
    
        return ObjectToConstruct(propertyOne: self.propertyOne,
                                propertyTwo: self.propertyTwo,
                                propertyThree: self.propertyThree)
        
    }
}


//MARK: Use of the Construction Builder pattern

let objectWithAllProperties = ConstructBuilder().withPropertyOne("Hola")
                                                .withPropertyTwo(["Hi","Allo"])
                                                .withPropertyThree(true)
                                                .build()


print(objectWithAllProperties)



let objectWithPropertyTwoByDefault = ConstructBuilder().withPropertyOne("Hola")
                    .withPropertyThree(true)
                    .build()

print(objectWithPropertyTwoByDefault)



//MARK: Strategy Builder pattern


class Vehicle {
    
    let numberOfPassengers: Int
    let numberOfWheels: Int
    let name: String
    
    var tryFly: Flys?
    
    init(numberOfPassengers: Int,numberOfWheels: Int, name: String){
    
        self.numberOfPassengers = numberOfPassengers
        self.numberOfWheels = numberOfWheels
        self.name = name
    }
}

class Car: Vehicle {
    
    let numberOfDoors: Int
    
    init(numberOfDoors: Int, numberOfPassengers: Int, numberOfWheels: Int, name: String) {
        
        self.numberOfDoors = numberOfDoors
        
        super.init(numberOfPassengers: numberOfPassengers, numberOfWheels: numberOfWheels, name: name)
        self.tryFly = CanNotFly()

    }
}

class Plane: Vehicle {
    
    let numberOfWings: Int


    init(numberOfWings: Int, numberOfDoors: Int, numberOfPassengers: Int, numberOfWheels: Int, name: String) {
        
        self.numberOfWings = numberOfWings

        super.init(numberOfPassengers: numberOfPassengers, numberOfWheels: numberOfWheels, name: name)
        self.tryFly = CanFly()

    }
}


class Train: Vehicle {
    
    let numberOfWagons: Int
    
    init(numberOfWagons: Int, numberOfDoors: Int, numberOfPassengers: Int, numberOfWheels: Int, name: String) {
        
        self.numberOfWagons = numberOfWagons

        super.init(numberOfPassengers: numberOfPassengers, numberOfWheels: numberOfWheels, name: name)
        self.tryFly = CanNotFly()

    }
}


protocol Flys{

    func fly() -> String
}

class CanFly: Flys {
    func fly() -> String {
        return "I can flyyyy :)"
    }
}

class CanNotFly: Flys {
    func fly() -> String {
        return "I can't fly :("
    }
}




//MARK: Use of the Strategy pattern


let car = Car(numberOfDoors: 4, numberOfPassengers: 4, numberOfWheels: 4, name: "Car")
let train = Train(numberOfWagons: 10, numberOfDoors: 20, numberOfPassengers: 250, numberOfWheels: 60, name: "Train")
let plane = Plane(numberOfWings: 2, numberOfDoors: 4, numberOfPassengers: 100, numberOfWheels: 2, name: "Plane")

print(car.tryFly!.fly())
print(train.tryFly!.fly())
print(plane.tryFly!.fly())

//Magic: This car now can Flys!!
car.tryFly = CanFly()

print(car.tryFly!.fly())



//MARK: Composite Builder pattern


protocol CompositeInterface {

    func addCompositeObject(compositeObject: CompositeInterface)
    func showInfo() -> String

}


class CompositeGroup: CompositeInterface {

    private var compositeElements: Array<CompositeInterface> = []
    
    var nameComposite: String
    
    init(name: String){
    
        self.nameComposite = name
    }
    
    func addCompositeObject(compositeObject: CompositeInterface){
    
        compositeElements.append(compositeObject)
    }

    func showInfo() -> String{
    

        return compositeElements.reduce("Composite object \(nameComposite)\n") { (info, element) -> String in
            
            return info + element.showInfo()
        }
        
    }

    
}

class CompositeLeaf: CompositeInterface {
    
    var nameComposite: String
    
    init(name: String){
        
        self.nameComposite = name
    }
    
    func addCompositeObject(compositeObject: CompositeInterface){
        
    }
    
    func showInfo() -> String{
        
        return "\t Composite Leaf \(nameComposite)"
        
    }
    
    
}


//MARK: Use of the Composite pattern


let composite = CompositeGroup(name: "Root Level")

let composite2 = CompositeGroup(name: "Second Level")
composite2.addCompositeObject(CompositeLeaf(name: "Third level"))
composite2.addCompositeObject(CompositeLeaf(name: "Third level brother"))

composite.addCompositeObject(composite2)

composite.showInfo()



//MARK: Builder pattern


protocol ObjectInterface{

    func setPartOne(partOne: String)
    func setPartTwo(partTwo: String)
    func setPartThree(partThree: String)
    
}

class ObjectToBuild: ObjectInterface {
    
    var partOne: String?
    var partTwo: String?
    var partThree: String?

    
    func setPartOne(partOne: String){ self.partOne = partOne }
    func setPartTwo(partTwo: String){ self.partTwo = partTwo }
    func setPartThree(partThree: String){ self.partThree = partThree }
    
    
}

protocol BuilderInterface{


    func buildPartOne()
    func buildPartTwo()
    func buildPartThree()
    
    func getObjectBuilded() -> ObjectToBuild

    
}


class CustomBuilderOne: BuilderInterface {
    
    private var objectToBuild: ObjectToBuild = ObjectToBuild()
    
    func buildPartOne(){ objectToBuild.setPartOne("Custom Part One") }
    func buildPartTwo(){ objectToBuild.setPartTwo("Custom part Two") }
    func buildPartThree(){ objectToBuild.setPartThree("Custom part Three") }
    
    func getObjectBuilded() -> ObjectToBuild {
        
        buildPartOne()
        buildPartTwo()
        buildPartThree()
        
        return self.objectToBuild
    
    }

}

class Client {
    
    var builder: BuilderInterface = CustomBuilderOne()
    
    func getObject() -> ObjectToBuild { return builder.getObjectBuilded() }
}


//MARK: Use of the Builder pattern


let client = Client()

let firstTypeOfObject = client.getObject()
print(firstTypeOfObject.partOne!)
print(firstTypeOfObject.partTwo!)
print(firstTypeOfObject.partThree!)


//MARK: New type of builder

class CustomBuilderTwo: BuilderInterface {
    
    private var objectToBuild: ObjectToBuild = ObjectToBuild()
    
    func buildPartOne(){ objectToBuild.setPartOne("Old Part One") }
    func buildPartTwo(){ objectToBuild.setPartTwo("Old part Two") }
    func buildPartThree(){ objectToBuild.setPartThree("Old part Three") }
    
    func getObjectBuilded() -> ObjectToBuild {
        
        buildPartOne()
        buildPartTwo()
        buildPartThree()
        
        
        return self.objectToBuild
        
    }
    
}

client.builder = CustomBuilderTwo()

let secondTypeOfObject = client.getObject()
print(secondTypeOfObject.partOne!)




//MARK: Abstract factory pattern


var abstractFactoryScheme = UIImageView(image: UIImage(named:"abstract.gif")!)


protocol AbstractProductA{

    func display() -> String
}

protocol AbstractProductB{
    
    func display() -> String
}

protocol AbstractFactory{

    func product1() -> AbstractProductA
    func product2() -> AbstractProductB
}

class ConcreteProductOneA: AbstractProductA {
    
    func display() -> String {
        
        return "Concrete product A 1"
    }
    
}

class ConcreteProductOneB: AbstractProductB {
    
    func display() -> String {
        
        return "Concrete product B 1"
    }
    
}

class ConcreteProductTwoA: AbstractProductA {
    
    func display() -> String {
        
        return "Concrete product A 2"
    }
    
}

class ConcreteProductTwoB: AbstractProductB {
    
    func display() -> String {
        
        return "Concrete product B 2"
    }
    
}

class ConcreteFactoryOne: AbstractFactory {
    
    func product1() -> AbstractProductA {
    
        return ConcreteProductOneA()
        
    }
    
    func product2() -> AbstractProductB {
    
        return ConcreteProductOneB()
    }
    
}

class ConcreteFactoryTwo: AbstractFactory {
    
    func product1() -> AbstractProductA {
        
        return ConcreteProductTwoA()
        
    }
    
    func product2() -> AbstractProductB {
        
        return ConcreteProductTwoB()
    }
    
}


//MARK: Use of the Abstract factory pattern


var factory: AbstractFactory = ConcreteFactoryOne()
var productA: AbstractProductA = factory.product1()
var productB: AbstractProductB = factory.product2()

print(productA.display())
print(productB.display())

factory = ConcreteFactoryTwo()
productA = factory.product1()
productB = factory.product2()

print(productA.display())
print(productB.display())


//MARK: Comand pattern

protocol BillPayer{

    func calculateBill(amountDue: Double) -> Double;
    
}

protocol Command {

    func executeCalculateBill(amountDue: Double) -> Double;

}

class WomanOver60: BillPayer {
    
    func calculateBill(amountDue: Double) -> Double{
    
        return amountDue - amountDue*0.10
    }
}

class ManOver60: BillPayer {
    
    func calculateBill(amountDue: Double) -> Double{
        
        return amountDue - amountDue*0.05
    }
}


class ManUnder60: BillPayer {
    
    func calculateBill(amountDue: Double) -> Double{
        
        return amountDue
    }
}

class Waiter: Command {
    
    var billPayer: BillPayer
    
    init(billPayer: BillPayer){
    
        self.billPayer = billPayer
    }
    
    func executeCalculateBill(amountDue: Double) -> Double{
        
        return billPayer.calculateBill(amountDue)
    }

}


class CashRegister {
    
    var command: Command
    
    init(command: Command){
    
        self.command = command
    }
    
    func returnFinalBill(amountDue: Double) -> Double{
    
        return self.command.executeCalculateBill(amountDue)
    }
}

class CustomerPicker{


    static func getWomanOver60() -> BillPayer{
    
        return WomanOver60()
    }
    
    static func getManOver60() -> BillPayer{
        
        return ManOver60()
    }
    
    static func getManUnder60() -> BillPayer{
        
        return ManUnder60()
    }
}


//MARK: Use of the Command pattern


var woman = CustomerPicker.getWomanOver60()

var waiter = Waiter(billPayer: woman)

var cashRegister = CashRegister(command: waiter)

var bill = cashRegister.returnFinalBill(60)

print("Bill is \(bill)")




