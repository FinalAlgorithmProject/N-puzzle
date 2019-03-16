//
//  Generator.swift
//  N-puzzle
//
//  Created by Kateryna Zakharchuk on 3/10/19.
//  Copyright © 2019 unit. All rights reserved.
//

import Foundation

final class Generator {
    
    var solvability: Solvability = .solvable
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
    
    func generateCustomPuzzle() {
        ArgumentParser().obtainCustomArguments { [weak self] (customSize, customIterations, customSolvability) in
            guard let self = self else { return }
            
            if let customSize = customSize,
                let customIterations = customIterations,
                let customSolvability = customSolvability {
                
                self.solvability = customSolvability
                self.iterations = customIterations
                self.size = customSize
                
                //
                let solvabilityName = self.solvability == .solvable ? "solvable" : "unsolvable"
                print("This puzzle is \(self.size)✗\(self.size) \(solvabilityName)")
            } else {
                print("Exit 🕳")
            }
        }
        
    }
}
