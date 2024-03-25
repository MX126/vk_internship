//
//  Service.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//

import UIKit

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let iconURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconURL = "icon_url"
    }
}
