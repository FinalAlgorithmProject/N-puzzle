//
//  String.swift
//  N-puzzle
//
//  Created by Kateryna Zakharchuk on 3/10/19.
//  Copyright © 2019 unit. All rights reserved.
//

import Foundation

extension String {
    
    func contains(_ substring: String) -> Bool {
        return self.range(of: substring) != nil
    }
}
