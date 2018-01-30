private class position {
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
// this is where the final result is stored 
private var molekyle/* this spelling mistake has to stay*/:Array<position> = [] 
//placeholder
var input: Array<String> = []

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
    // remembers if the value of the input haveing the same index is a position, amount or binding type
func makeTypeMap(origin:Array<String>) -> Array<String>{
    var output:Array<String> = replaceElement(master: origin, target: "thyl", new: "extention")
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
    return output
}

    /*for i in 0 ... ((input.endIndex)-1) {
        var element = type(of: input[i])
        print(type(of: element))
        type(of: type(of: element))
        
        if element==String.self {
            if (String(describing: input[i]) == "tan" ) {
                informationType.insert("bindingType", at: i)
            } else if (String(describing: input[i]) == "tin" ) {
                if informationType[i-1] == "amount"{
                    
                } else {
                    <#code#>
                }
            } else if (String(describing: input[i]) == "ten" )  {
                <#code#>
            } else if String(describing: input[i]) == "thyl" {
                informationType.insert("extention", at: i)
            } else {
                informationType.insert("amount", at: i)
            } 
        } else {
            informationType.insert("position", at: i)
        }
        
        
        
    }*/


