class position {
    func set(binding: Int, around: Array<String>) {
        bindingSize = binding
        border = around
    }
    
    // 0= none; 1= single binding; 2= double binding; 3= tripple
    var bindingSize = 1
    // 0= none; 1= first direction ; 2= second direction
    var extended = 0
    // molecule extention is a list of positions itself 
    var extention:Array<position> = []
    // clockwise 
    var border:Array<String> = Array(repeating: "", count: 4)
    
}// returns a list of atoms which have the given binding Size
func getPlaces(input: Array<String>, typeMap: Array<String>, checkFor: String, totalLength: Int) -> Array<Int> {
    var counter = 1
    var places:Array<Int> = []
    // here we check whether an bindng size indicator belongs to the main molecule or one of its Forks
    for candidate in input {
        print(counter)
        if counter > typeMap.count {
            print(typeMap.count)
        } else if candidate == checkFor && typeMap[counter-1] != "extention" {
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
    
    let placesDouble = getPlaces(input: input, typeMap: typeMap, checkFor: "en", totalLength: inputMolecuele.count)
    let placesTriple = getPlaces(input: input, typeMap: typeMap, checkFor: "in",totalLength: inputMolecuele.count)
    
    placesDouble.forEach{ element in placesDouble
        //the chemical counting starts with 1, the array with 0, thaths why we have to do element - 1
        outputMolecule[element-1].bindingSize = 2
        outputMolecule
    }
    placesTriple.forEach{ element in placesTriple
        outputMolecule[element-1].bindingSize = 3
    }
    
    return outputMolecule
}

