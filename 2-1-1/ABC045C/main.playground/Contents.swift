import UIKit

extension String {
    func toArray() -> [String] {
        var str = self
        for i in 0 ..< (str.count - 1) {
            str.insert(",", at: str.index(str.startIndex, offsetBy: (i + 1) + i))
        }
        return str.components(separatedBy: ",")
    }
    
    func eval() -> Int {
        return components(separatedBy: "+").map { Int($0)! }.reduce(0, +)
    }
}

let input = "9999999999"

let inputArray = input.toArray()
let count = inputArray.count

func solve(offset: Int = 0, formula: String = "") -> String {
    
    if offset == count - 2 {
        let plus = formula + "+" + inputArray.last!
        let renketsu = formula + inputArray.last!
        return String(plus.eval() + renketsu.eval())
    }
    
    let plus: String
    let renketsu: String
    if offset == 0 {
        plus = solve(offset: offset + 1, formula: "\(inputArray[offset])+\(inputArray[offset + 1])")
        renketsu = solve(offset: offset + 1, formula: "\(inputArray[offset])" + "\(inputArray[offset + 1])")
    } else {
        plus = solve(offset: offset + 1, formula: "\(formula)+\(inputArray[offset + 1])")
        renketsu = solve(offset: offset + 1, formula: "\(formula)\(inputArray[offset + 1])")
    }
    return String(Int(plus)! + Int(renketsu)!)
}

print(solve())
