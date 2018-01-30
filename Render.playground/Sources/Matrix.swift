//this struckt will bee the key of the matrix 
public struct DualInt: Hashable, remarkable{
    let x: Int
    let y: Int
    public var marker: Int?
    
   public init(x: Int, y:Int){
        self.x = x
        self.y = y
    }
    
     public static func + (left: DualInt, right: DualInt) -> DualInt{
        return DualInt(x: left.x + right.x, y: left.y + right.y)
    }
    
    public static prefix func - (add: DualInt) -> DualInt{
        return DualInt(x:  -add.x, y: -add.y)
    }
    
    public static func ==(lhs: DualInt, rhs: DualInt) -> Bool {
        return (lhs.x, lhs.y) == (rhs.x, rhs.y)
    }
    
    public var hashValue: Int {
        // Combine the hash values for the name and department
        return x.hashValue << 2 | y.hashValue
    }
}
//the function to expand the matrix needs the values to be initallizable
public protocol explicit: Any {
    init()
}
//bad pun ahead 
public protocol remarkable {
    var marker:Int? {get set}
}

//some possible errors 
public enum MatrixError:Error {
    case outOfRange
    case negativeValue
}
//the matrix
public struct matrix<T: explicit> {
    public init(){
      colums = 1
      rows = 1
      matrix = Dictionary()
    }
    //the values get stored in a dictionary (it is used like a dual-index array)
    private var matrix:Dictionary<DualInt,T> = Dictionary() 
    //setting this resizes the matrix 
    public var colums = 1 {
    willSet{
        if newValue > colums {
            for i in colums ... newValue {
                addColum()
            }
        } else if newValue > 0 {
            //deleteing the removed collums
            for i in self.matrix  {
                if i.key.x > newValue {
                    self.matrix[i.key] = nil
                }
            }
        }
        }
    }
        public var rows = 1 {
        willSet{
            if newValue > rows {
                for i in rows ... newValue {
                    addRow()
                }
            } else if newValue > 0 {
                for i in self.matrix  {
                    if i.key.y > newValue {
                        self.matrix[i.key] = nil
                    }
                }
            }
        }
    }
    
    public subscript(x: Int, y: Int) -> T {
        get  {
            //TODO: research whether throwing an error instant is possible 
            precondition((x > colums || y > rows) || (x < 1 || y < 1), "out of range ")
            return matrix[DualInt(x: x, y: y)]!
        }
        set {
            precondition((x > colums || y > rows) || (x < 1 || y < 1), "out of range ")
            matrix[DualInt(x: x, y: y)]! = newValue
        }
    }
    private mutating func addColum() {
        for i in 0...rows{
            self.matrix[DualInt(x: colums + 1, y: i)] = T()
        }
    }
    private mutating func addRow() {
        for i in 0...colums{
            self.matrix[DualInt(x: i, y: rows + 1)] = T()
        }
    }
    public mutating func set(x:Int, y:Int,value:T) throws  {
        if x > colums || y > rows {
            throw MatrixError.outOfRange
        } else if x < 1 || y < 1{
            throw MatrixError.negativeValue
        }
        self.matrix[DualInt(x: x, y: y)] = value
        
    }
    //paste a Matrix into another
    public mutating func insert(position: DualInt, content: matrix) {
        //coordinates start counting with 0, rows and columns with 1
        if position.x + content.colums > self.colums{
            self.colums = position.x + content.colums
        }
        if position.y + content.rows > self.rows{
            self.rows = position.y + content.rows
        }
        for e in content.matrix {
            self.matrix[e.key + position] = e.value
        }
    }
    //turns everything by 90 degrees (clockwise)
    public mutating func turn() {
        var newMatrix: Dictionary<DualInt,T> = Dictionary()
        for e in matrix {
            newMatrix[DualInt(x: e.key.y, y: e.key.x)] = e.value
        }
        matrix = newMatrix
    }
    
}
