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
            if readLine.contains(Arguments.solvable.rawValue) &&
                readLine.contains(Arguments.unsolvable.rawValue) {
                print("Can't be both solvable AND unsolvable, dummy! 🤯")
                return
            }
            
        }
    }
    
    func obtainPuzzleSize(completion: ((_ quit: Bool) -> Void)?) {
        print("Please enter size of the puzzle's side. Must be > 2.\"\nIf you want to exit, white \"quit\"")
        while let input = readLine() {
            guard input != "quit" else {
                completion?(true)
                break
            }
            
            if let size = Int(input) {
                if size > 2 {
                    self.size = size
                    completion?(false)
                } else {
                    print("Size of the puzzle's side must be > 2.")
                }
            } else {
                print("Please enter correct size of the puzzle's side. It must be integer and > 2.")
            }
        }
    }
    
    func obtainPassesCount(completion: ((_ quit: Bool) -> Void)?) {
        print("Do you want to setup a specific number of iterations? - yes/no")
        while let input = readLine() {
            guard input != "quit" else {
                completion?(true)
                break
            }
            
            if input == "yes" {
                print("Please enter number of passes")
                while let input = readLine() {
                    guard input != "quit" else {
                        completion?(true)
                        break
                    }
                    
                    if let iterations = Int(input) {
                        if iterations > 0 && iterations <= 10000 {
                            self.iterations = iterations
                            completion?(false)
                        } else {
                            print("Number of passes must be > 0 and <= 10000.")
                        }
                    } else {
                        print("Please enter correct number of passes. It must be integer and > 0.")
                    }
                }
            } else if input == "no" {
                completion?(false)
            } else {
                print("Please answer 'yes' or 'no'.\"\nIf you want to exit, white \"quit\"")
            }
        }
    }
    
    func obtainSolvability(completion: ((_ quit: Bool) -> Void)?) {
        print("Do you want to set the puzzle solvability? - yes/no")
        while let input = readLine() {
            guard input != "quit" else {
                completion?(true)
                break
            }
            
            if input == "yes" {
                print("Please enter parameters: [-s] - Forces generation of a solvable puzzle. Overrides -u.\n[-u] - Forces generation of an unsolvable puzzle")
                while let input = readLine() {
                    guard input != "quit" else {
                        completion?(true)
                        break
                    }
                    
                    if  iterations = Int(input) {
                        
                    } else {
                        print("Please enter correct number of passes. It must be integer and > 0.")
                    }
                }
            } else if input == "no" {
                print("Thanks, solvability of the puzzle will be selected randomly.")
                completion?(false)
            } else {
                print("Please answer 'yes' or 'no'.\"\nIf you want to exit, white \"quit\"")
            }
        }
    }
}
