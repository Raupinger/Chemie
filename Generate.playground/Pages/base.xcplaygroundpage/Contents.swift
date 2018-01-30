class position {
    func set(binding: Int, around: Array<String>) {
        bindingSize = binding
        border = around
    }
    
    // 0= none; 1= single binding; 2= double binding; 3= tripple
    var bindingSize = 1
    // 0= none; 1= first direction ; 2= second direction
    var extended = 0
    // molekyle extention is a list of positions itself 
    var extention:Array<position> = []
    // clockwise 
    var border:Array<String> = Array(repeating: "", count: 4)
    
}
// this one turnes the (semi) greek numbers into intger values
func textNumber(text: String)-> Int {
    if text == "meth" || text == "me" {
        return 1
    } else if text == "eth" || text == "e" {
        return 2
    } else if text == "pro" {
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
    output.forEach { objective in output
        objective.border = ["","H","","H"]
    }
    output.last?.bindingSize = 0
    output.last?.border = ["","H","H","H"]
    output.first?.border = ["H","H","","H"]
    return output
}
base(input: ["2","5","di","meth","yl","non","an"], typeMap: <#T##Array<String>#>)
