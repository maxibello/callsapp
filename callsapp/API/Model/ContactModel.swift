//
//  ContactModel.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 30.03.2021.
//

import Foundation

struct CallModel: Codable {
    var id: String?
    var client: ClientModel?
    var businessNumber: BusinessNumberModel?
    var created: String?
    private var duration: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case client
        case businessNumber
        case created
        case duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decodeIfPresent(String.self, forKey: .id)
        client = try? container.decodeIfPresent(ClientModel.self, forKey: .client)
        businessNumber = try? container.decodeIfPresent(BusinessNumberModel.self, forKey: .businessNumber)
        created = try? container.decodeIfPresent(String.self, forKey: .created)
        duration = try? container.decodeIfPresent(String.self, forKey: .duration)
    }
    
    var date: Date? {
        guard let created = created else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: created)
    }
    
    var time: String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    var durationMinSec: String? {
        guard let duration  = duration else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        guard let time = formatter.date(from: duration) else { return nil }
        formatter.dateFormat = "mm:ss"
        return formatter.string(from: time)
    }
}

struct CallsModel: Codable {
    var requests: [CallModel]?
    
    enum CodingKeys: CodingKey {
        case requests
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        requests = try? container.decode([CallModel].self, forKey: .requests)
    }
}

struct ClientModel: Codable {
    var name: String?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case address
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        address = try? container.decodeIfPresent(String.self, forKey: .address)
    }
}

struct BusinessNumberModel: Codable {
    var number: String?
    var label: String?
}
