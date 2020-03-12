//
//  CoinData.swift
//  RealTimeTicker
//
//  Created by Bartek on 3/12/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation

import Foundation
//Decodable is used if you want to decode the JSON but if you wanna turn it back then use Codable
struct CoinData: Decodable {
    let rate: Double
}

