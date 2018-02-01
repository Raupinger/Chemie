public struct position {
    public mutating func set(binding: Int, around: Array<String>) {
        bindingSize = binding
        border = around
    }
    
    // 0= none; 1= single binding; 2= double binding; 3= tripple; 
    public var bindingSize = 1
    // 0 = up; 1= middle; 2= down
    public var direction = 1
    // 0= none; 1= first direction ; 2= second direction
    public var extended = 0
    // molecule extention is a list of positions itself 
    public var extention:Array<position> = []
    // clockwise 
    public var border:Array<String> = Array(repeating: "", count: 4)
    
} 