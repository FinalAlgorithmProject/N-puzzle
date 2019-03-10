//
//  Generator.swift
//  N-puzzle
//
//  Created by Kateryna Zakharchuk on 3/10/19.
//  Copyright © 2019 unit. All rights reserved.
//

import Foundation

/* Arguments:
 - size
 - solvable/unsolvable
 - iterations
 */

enum Solvability {
    case solvable
    case unsolvable
    
    func options() -> [Solvability] {
        return [.solvable, .unsolvable]
    }
    
    func randomOption() -> Solvability {
        let options = self.options()
        let randomIndex = Int(arc4random_uniform(UInt32(options.count)))
        
        return options[randomIndex]
    }
}

enum Arguments: String {
    case solvable = "-s"
    case unsolvable = "-u"
    case iterations = "-i"
    case size = "size"
    
    func getAll() -> [Arguments] {
        return [.solvable, .unsolvable, .iterations, .size]
    }
}

final class Generator {

    var solvability: Solvability? = nil
    var iterations = 10000
    var size = 3
    
    var arguments = [Arguments]()
    
    func makeGoal(with size: Int) -> [Int] {
        var puzzle = [Int]()
        for i in 0..<size {
            puzzle.append(i)
        }
        
        var cur = 1
        var x = 0
        var ix = 1
        var y = 0
        var iy = 0
        
        while true {
            puzzle[x + y * size] = cur
            if cur == 0 { break }
            if x + ix == size || x + ix < 0 || (ix != 0 && puzzle[x + ix + y*size] != -1) {
                iy = ix
                ix = 0
            } else if y + iy == size || y + iy < 0 || (iy != 0 && puzzle[x + (y+iy)*size] != -1) {
                ix = -iy
                iy = 0
            }
            x += ix
            y += iy
            cur == size*size ? cur = 0 : ()
        }
        return puzzle
    }
    
    func basicInput() {
        print("Please enter parameters: [-s] - \"Forces generation of a solvable puzzle. Overrides -u.\"\n[-u] - \"Forces generation of an unsolvable puzzle\"\n[-i ITERATIONS] - \"Number of passes\"\nsize - \"Size of the puzzle's side. Must be >3.\"\n")
        if let readLine = readLine() {
            
        }
    }
}
