//
//  CallsRequest.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 30.03.2021.
//

import Foundation

class CallsRequest: APIRequest {
    var method = RequestType.GET
    var path = "testapi"
    var parameters = [String: String]()
}
