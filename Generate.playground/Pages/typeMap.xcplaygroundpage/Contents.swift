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
    
}
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
    output = replaceElement(master: output, target: "thyl", new: "extention")
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
            
            return []
        }
        counter = counter + 1
    }
    return output
}
print(makeTypeMap(origin: ["2","5","di","meth","yl","non","an"]))

