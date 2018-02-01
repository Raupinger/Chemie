
public struct position {
    // 0= none; 1= single binding; 2= double binding; 3= tripple; 
    public var bindings = Array(repeating: 1, count: 4)
    // clockwise 
    public var border:Array<neighbour> = [.prior, .H, .next, .H]
    
} 
public enum neighbour {
    case extention(Array<position>)
    case prior
    case next
    case atom(Character, Array<Int>)
    case H
    case nothing
}
