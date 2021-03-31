//
//  CallsViewModel.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 30.03.2021.
//

import Foundation
import RxSwift

class CallsViewModel {
    let apiClient = APIClient()
    
    var items: Observable<CallsModel> {
        let request = CallsRequest()
        return apiClient.send(apiRequest: request)
    }
}
