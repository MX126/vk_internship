//
//  ApiResponse.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//

import Foundation

struct ApiResponse: Decodable {
    let body: ResponseBody
    let status: Int
}
