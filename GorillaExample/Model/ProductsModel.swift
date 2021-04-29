//
//  ProductsModel.swift
//  GorillaExample
//
//  Created by Julian Barco on 29/04/21.
//

import Foundation

struct ProductsModel: Codable{
    var name1: String?
    var name2: String?
    var price: String?
    var bg_color: String?
    var type: String?

    private enum CodingKeys: String, CodingKey {
        case name1
        case name2
        case price
        case bg_color
        case type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode (name1, forKey: .name1)
        try container.encode (name2, forKey: .name2)
        try container.encode (price, forKey: .price)
        try container.encode (bg_color, forKey: .bg_color)
        try container.encode (type, forKey: .type)
        
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name1 = try values.decodeIfPresent(String.self, forKey: .name1) ?? ""
        self.name2 = try values.decodeIfPresent(String.self, forKey: .name2) ?? ""
        self.price = try values.decodeIfPresent(String.self, forKey: .price) ?? ""
        self.bg_color = try values.decodeIfPresent(String.self, forKey: .bg_color) ?? ""
        self.type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        
    }
}
