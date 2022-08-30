//
//  NetworkRepository.swift
//  Serbaseleb
//
//  Created by irfan pertadima on 09/10/21.
//  Copyright © 2021 Mactur. All rights reserved.
//

import RxSwift
import Alamofire
import Foundation

protocol ApiServices {
    func doBlockTalent(talentId: Int, request: BlockTalentRequest) -> Observable<BlockTalentResponse?>)
}

class NetworkRepository : ApiServices {
    private let service: NetworkManager
    private let constantUrl: ConstantURL
    
    init(service: NetworkManager = NetworkManager(), constantUrl: ConstantURL = ConstantURL()) {
        self.service = service
        self.constantUrl = constantUrl
    }
    
    func doBlockTalent(talentId: Int, request: BlockTalentRequest) -> Observable<BlockTalentResponse?> {
        return service.requestPost(urlString: "\(constantUrl.getEndpointUrl(endpoint: .block))\(talentId)", parameters: request, encoding: URLEncoding.default)
    }

    
}



