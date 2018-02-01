//containes only the necessary information ( example: dimeth → meth)
public let firstInput = ["2","4","meth","yl","hex","2","en"]


func replaceElement(master: Array<String>, target: String, new:String) -> Array<String> {
    var index = 0
    var output:Array<String> = master
    for candidate in master {
        if candidate == target {
            output[index] = new
        }
        index = index + 1 
    }
    return output
}

func makeTypeMap(origin:Array<String>) -> Array<String>{
    var output:Array<String> = replaceElement(master: origin, target: "yl", new: "extention")
    //output = replaceElement(master: output, target: "thyl", new: "extention")
    for number in ["1","2","3","4","5","6","7","8","9"] {
        output = replaceElement(master: output, target: number, new: "place")
    }
    for number in ["meth","eth","prop","but","pent","hex","sept","oct","non"] {
        output = replaceElement(master: output, target: number, new: "length")
    }
    
    for number in ["di","tri","mono","penta","hexa"] {
        output = replaceElement(master: output, target: number, new: "amount")
    }
    for number in ["an","en","in"] {
        output = replaceElement(master: output, target: number, new: "bindingSize")
    }
    var counter = 0
    for candidate in output {
        
        if candidate == origin[counter] {
            print("error:")
            print(candidate)
            return []
        }
        counter = counter + 1
    }
    return output
}
print(makeTypeMap(origin: ["2","5","di","meth","yl","non","an"]))
// this one turnes the (semi) greek numbers into intger values
func textNumber(text: String)-> Int {
    if text == "meth" || text == "me" {
        return 1
    } else if text == "eth" || text == "e" {
        return 2
    } else if text == "prop" {
        return 3
    } else if text == "but" || text == "bu" {
        return 4
    } else if text == "pent" || text == "pen" {
        return 5
    } else if text == "hex"  {
        return 6
    } else if text == "sept" || text == "sep" {
        return 7
    } else if text == "oct" || text == "oc" {
        return 8
    } else if text == "non" {
        return 9
    } else {
        return 0
        print(text)
    }
}
// the base(Array<String>) functions pourpose is to figure out how long the main fork of the molecule has to be and to set the default properties for each atom
private func base(input: Array<String>, typeMap: Array<String>)-> Array<position> {
    
    var textLength = ""
    var counter = 0
    //searches the main length indcator
    for  candidate in typeMap {
        if candidate == "length" && typeMap[counter + 1] != "extention" {
            textLength = input[counter]
        } 
        counter = counter + 1
    }
    if textLength == "" {
        print("no length found, check input")
    }
    print(textLength)
    var output:Array<position> = [position()]
    for i in 1 ... textNumber(text: textLength)-1 {
        output.append(position())
    }
    
    output[output.count - 1].bindings[2] = 0
    output[output.count - 1].border = [.prior,.H,.H,.H]
    output[0].border = [.H,.H,.next,.H]
    return output
}


// returns a list of atoms which have the given binding Size
func getPlaces(input: Array<String>, typeMap: Array<String>, checkFor: String) -> Array<Int> {
    var counter = 1
    var places:Array<Int> = []
    // here we check whether an bindng size indicator belongs to the main molecule or one of its Forks
    for candidate in input {
        print(counter)
        if counter > typeMap.count {
            print(typeMap.count)
        } else if candidate == checkFor && typeMap[counter-1] != "extention" {
            print(candidate)
            // getting all the positions of the binding Size
            //the counter wich is the index of the marker started with 1, it is 1 in front of the first position number
            var index = counter - 2
            var stilPosition = true
            while stilPosition == true {
                
                if typeMap[index] == "place"{
                    places.append(Int(input[index])!)
                } else {
                    stilPosition = false
                    return places
                }
                index = index - 1
            }
        }  
        counter = counter + 1
    }
    return places
}
// figures out wehre double and tripple bindings are
func addBindingSizes(inputMolecuele: Array<position>, input: Array<String>, typeMap: Array<String>)-> Array<position> {
    print(typeMap)
    var outputMolecule:Array<position> = inputMolecuele
    
    let placesDouble = getPlaces(input: input, typeMap: typeMap, checkFor: "en")
    let placesTriple = getPlaces(input: input, typeMap: typeMap, checkFor: "in")
        // TODO: GENERAL: remove Redundancy 
        // TODO: E/Z: add flexibility 
    placesDouble.forEach{ element in placesDouble
        //the chemical counting starts with 1, the array with 0, thats why we have to do element - 1
        outputMolecule[element-1].bindings = [outputMolecule[element - 1].bindings[0], 1, 2]
            // lowering the amount of neighbors to 3 
        outputMolecule[element-1].border = [outputMolecule[element - 1].border[0], .H, outputMolecule[element - 1].border[2] ]
            // adjusting the binding of a potential next position 
        do {
            print(outputMolecule[element])
            outputMolecule[element].bindings = [2, 1, outputMolecule[element].bindings[3]]
            // lowering the amount of neighbors to 3 
            outputMolecule[element].border = [outputMolecule[element].border[0], .H, outputMolecule[element].border[2] ]
        } 
    }
    placesTriple.forEach{ element in placesTriple
        outputMolecule[element-1].bindings = [outputMolecule[element - 1].bindings[0], 3]
        // lowering the amount of neighbors to 2 
        outputMolecule[element-1].border = [outputMolecule[element - 1].border[0], outputMolecule[element - 1].border[2] ]
        do {
            outputMolecule[element].bindings = [3, outputMolecule[element].bindings[3]]
            // lowering the amount of neighbors to 2
            outputMolecule[element].border = [outputMolecule[element].border[0], outputMolecule[element].border[2] ]
        }
    }
    
    return outputMolecule
}

func getExtentions(inputMolecuele: Array<position>, input: Array<String>, typeMap: Array<String>)-> Array<position> {
    //placeholder 
    // TODO: E/Z: add flexibility 
    var direction = 1
    
    var outputMolecule:Array<position> = inputMolecuele
    var indexes:Array<Int> = []
    var i = 0
    for element in typeMap {
        if element == "extention" {
            indexes.append(i)
        }
        i = i + 1
    }
    print(indexes)
    var places:Array<Int> = []
    var sizes:Array<String> = []
    // very similar to getPlaces()
    for element in  indexes {
        //the counter wich is the index of the marker started with 1, it is 1 in front of the first position number
        var index = element - 2
        var stilPosition = true
        while stilPosition == true {
            if index < 0 {
                stilPosition = false
            } else if typeMap[index] == "place"{
                places.append(Int(input[index])!)
                sizes.append(input[element])
            } else {
                stilPosition = false
            }
            index = index - 1
        }
    }
    print(places)
    i = 0
    for element in  places {
        
        
        var extention:Array<position> = []
        for ii in 0 ... textNumber(text: sizes[i]) {
            var new = position()
            new.border = [.prior,.H,.next,.H]
            extention.append(new)
        }
        extention[extention.count-1].border[3] = .H
        //compensating for counting methods 
        outputMolecule[element - 1].border[direction] = .extention(extention)
        i = i + 1
    }
    return outputMolecule
}


let types = makeTypeMap(origin: firstInput)
let start = base(input: firstInput, typeMap: types)
let withBindings = addBindingSizes(inputMolecuele: start, input: firstInput, typeMap: types)
let withExtentions = getExtentions(inputMolecuele: withBindings, input: firstInput, typeMap: types)
for e in withExtentions {
    e.bindings
    e.border.forEach{ ee in e
        ee
    }
}
