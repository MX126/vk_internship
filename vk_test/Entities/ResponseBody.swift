//
//  ResponseBody.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//

import Foundation

struct ResponseBody: Decodable {
    let services: [Service]
}
