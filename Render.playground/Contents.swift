
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

var firstInput = [position(),position(),position()]
firstInput[0].border = ["H","H","","H"]
firstInput[1].border = ["","","",""]
firstInput[1].extended = 1
firstInput[1].extention = Array(repeating: position(), count: 1)
firstInput[2].border = ["","H","","H"]
firstInput[1].bindingSize = 2
firstInput.last?.bindingSize = 0

 struct key {
    var c:Bool
    var Content:String
}
    var result = ""
    //this variable holds the index of the first c atom
    var start:Array<key> = []
    //we will need them later
    var top:Array<Array<key>> = []
    var bottom:Array<Array<key>> = []
    //we start with the line containing the main fork
    var centerLine:Array<key> = []
    
    if (firstInput.first?.border.first)! != "" {
        centerLine.append(key(c: false, Content: (firstInput.first?.border.first)!))
        centerLine.append(key(c: false, Content: "-"))
        start.append(contentsOf: [key(c: false, Content: ""),key(c: false, Content: "")])
    } 
    for element in firstInput {
        centerLine.append(key(c: true, Content: "C"))
        if element.bindingSize == 1 {
            centerLine.append(key(c: false, Content: "-"))
        } else if element.bindingSize == 2 {
            centerLine.append(key(c: false, Content: "-"))
        } else if element.bindingSize == 3 {
            centerLine.append(key(c: false, Content: "\\equiv"))
        }
    }
    centerLine.append(key(c: false, Content: (firstInput.last?.border[2])!))
    centerLine.append(key(c: false, Content: "\\\\"))
    
    //the section below adds the surounding atoms
    var bindingsUp = start
    var atomsUp = start
    for element in firstInput {
        if element.border[1] != "" {
            bindingsUp.append(key(c: false,Content: "|"))
            atomsUp.append(key(c: false, Content: element.border[1]))
        } else {
            bindingsUp.append(key(c: false, Content: ""))
            atomsUp.append(key(c: false, Content: ""))
        }
        atomsUp.append(key(c: false, Content: ""))
        bindingsUp.append(key(c: false, Content: ""))
    }
    bindingsUp.append(key(c: false, Content: "\\\\"))
    atomsUp.append(key(c: false, Content: "\\\\"))
    top.append(bindingsUp)
    top.append(atomsUp)
    
    //var bindingsDown = bindingsUp
    
    var bindingsDown = start
    var atomsDown = start
    for element in firstInput {
        if element.border[3] != "" {
            bindingsDown.append(key(c: false, Content: "|"))
            atomsDown.append(key(c: false,Content: element.border[3]))
        } else {
            bindingsDown.append(key(c: false, Content: ""))
            atomsDown.append(key(c: false, Content: ""))
        }
        atomsDown.append(key(c: false, Content: ""))
        bindingsDown.append(key(c: false, Content: ""))
    }
    bindingsDown.append(key(c: false, Content: "\\\\"))
    atomsDown.append(key(c: false, Content: "\\\\"))
    bottom.append(bindingsDown)
    bottom.append(atomsDown)
    
var z = 1
    var i = start.count 
    for candidate in firstInput {
        if z < firstInput.count {
        if candidate.extended != 0 {
            
            
            centerLine.insert(centerLine[i-1], at: i)
            
            var ii = 0
            top.forEach{ e in top
                if e[i].Content == ""{
                    top[ii].insert(key(c: false, Content: ""), at: i)
                    
                } else {
                    
                }
                ii = ii + 1
            }
             ii = 0
            bottom.forEach{ e in bottom
                if e[i].Content == ""{
                    bottom[ii].insert(key(c: false, Content: ""), at: i)
                } else {
                    
                }
                ii = ii + 1
            }
            i = i + 2
            centerLine.insert(centerLine[i], at: i)
            
             ii = 0
            top.forEach{ e in top
                if e[i].Content == ""{
                    top[ii].insert(key(c: false, Content: ""), at: i)
                    
                } else {
                    
                }
                ii = ii + 1
            }
            ii = 0
            bottom.forEach{ e in bottom
                if e[i].Content == ""{
                    bottom[ii].insert(key(c: false, Content: ""), at: i)
                } else {
                    
                }
                ii = ii + 1
            }
            i = i - 1
            top[0][i] = key(c: false, Content: "|")
            
            var direction:Array<Array<key>> = []
            if candidate.extended == 1 {
                direction = top
            } else if candidate.extended == 2 {
                direction = bottom
            }
             ii = -01
            print(i)
            for element in candidate.extention {
                if direction.count < ii + 3 {
                    direction.append(Array(repeating: key(c: false, Content: ""), count: centerLine.count))
                }
                var line = direction[2 + ii]
                print(i)
                line[i-2] = key(c: false, Content: element.border[2]) 
                line[i-1] = key(c: false, Content: "-")
                line[i] = key(c: true, Content: "C")
                line[i+1] = key(c: false, Content: "-")
                line[i+2] = key(c:false,Content: element.border[3])
                line[centerLine.count - 1] = key(c: false, Content: "\\\\")
                direction[2 + ii] = line
                ii = ii + 1
                
            }
            if direction.count < ii + 3 {
                direction.append(Array(repeating: key(c: false, Content: ""), count: centerLine.count))
                direction[direction.count - 1][direction[direction.count - 1].count - 1] = key(c: false, Content: "\\\\")
                direction.append(Array(repeating: key(c: false, Content: ""), count: centerLine.count))
                direction[direction.count - 1][direction[direction.count - 1].count - 1] = key(c: false, Content: "\\\\")
            }
            direction[ii + 3][i] = (key(c: false,Content: (candidate.extention.last?.border[2])!))
            direction[ii + 2][i] = key(c: false, Content: "|")
            if candidate.extended == 1 {
                top = direction
            } else if candidate.extended == 2 {
                bottom = direction
            }
            
        }
        i = i+1
        
        while centerLine[i].c != true {
            i = i + 1
        }
        }
        z = z + 1
    }
    
    top = top.reversed()
    
    
    result.append("\\begin{matrix}")
    top.forEach{ element in top
        element.forEach{ thing in element
            result.append(thing.Content)
            result.append("&")
        }
    }
centerLine.forEach{ thing in centerLine
    result.append(thing.Content)
    result.append("&")
}
    bottom.forEach{ element in bottom
        element.forEach{ thing in element
            result.append(thing.Content)
            result.append("&")
        }
    }
    result.append("\\end{matrix}")
    print(result)
    



