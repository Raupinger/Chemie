
extension String: explicit {}
// this one is universal for every branch
public func make(input: Array<position>) {
    var mat = matrix<String>()
    //5 rows: the central line + 2x conecting lines + 2x H atoms
    mat.rows = 5
        //these are only for the main branch 
    mat.colums = (input.count / 2) - 1
}
