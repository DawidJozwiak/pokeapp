//
//  Pokemon.swift
//  Pokeapp
//
//  Created by Dawid Jóźwiak on 13/07/2022.
//

import Foundation
import UIKit

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let type: String
    var image: UIImage?
    var isFavourite = false
}
