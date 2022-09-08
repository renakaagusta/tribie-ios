//
//  ApiClient.swift
//  tribie
//
//  Created by renaka agusta on 19/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class NetworkManager {
    private lazy var appKeychain = AppKeychain()
    
    enum ApiError: Error {
        case forbidden
        case notFound
        case conflict
        case internalServerError
        case responseNil
    }
    
    enum DocType {
        case image
        case document(url: URL)
    }
    
    public func requestGet<T: Codable>(urlString: String) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.request(urlString, method: .get, headers: [
                AppConstant.CONTENT_TYPE : AppConstant.APPLICATION_JSON,
                AppConstant.CLIENT_KEY : "",
                AppConstant.ACCEPT : AppConstant.APPLICATION_JSON,
                AppConstant.AUTHORIZATION : "Bearer \(self.appKeychain.appToken())"
            ]).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        do {
                            let result = try decoder.decode(T.self, from: json)
        
//                            Logger.info("======SEND GET REQUEST=======")
//                            Logger.info(urlString)
//                            Logger.info("===========RESPONSE===========")
//                            Logger.info(result)
                            
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch let error {
//                            Logger.error("======SEND POST REQUEST=======")
//                            Logger.error(urlString)
//                            Logger.error("============ERROR=============")
//                            Logger.error(error)
                                
                            observer.onError(error)
                        }
                    } else {
                        Logger.error("======SEND POST REQUEST=======")
                        Logger.error(urlString)
                        Logger.error("==========ERROR NIL============")
                        
                        observer.onError(ApiError.responseNil)
                    }
                case .failure(let error):
                    let errorException = self.getFailureError(statusCode: response.response?.statusCode, error: error)
                    observer.onError(errorException)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    public func requestGetNoContentType<T: Codable>(urlString: String) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.request(urlString, method: .get, headers: [
                AppConstant.CLIENT_KEY : "",
                AppConstant.ACCEPT : AppConstant.APPLICATION_JSON,
                AppConstant.AUTHORIZATION : "Bearer \(self.appKeychain.appToken())"
            ]).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        do {
                            let result = try decoder.decode(T.self, from: json)
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    } else {
                        observer.onError(ApiError.responseNil)
                    }
                case .failure(let error):
                    let errorException = self.getFailureError(statusCode: response.response?.statusCode, error: error)
                    observer.onError(errorException)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    public func requestPost<T: Codable, X: Codable>(
        urlString: String,
        parameters: X? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameters!)
            
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue(AppConstant.APPLICATION_JSON, forHTTPHeaderField: AppConstant.CONTENT_TYPE)
            urlRequest.addValue("Bearer \(self.appKeychain.appToken())", forHTTPHeaderField: AppConstant.AUTHORIZATION)
            urlRequest.httpBody = data
           
            let request =  AF.request(urlRequest).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        do {
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(T.self, from: json)
        
                            Logger.info("======SEND POST REQUEST=======")
                            Logger.info(urlString)
                            Logger.info("=======PARAMETERS========")
                            Logger.info(parameters)
                            Logger.info("===========RESPONSE===========")
                            Logger.info(response)
                            
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch let error {
                            
                            Logger.error("======SEND POST REQUEST=======")
                            Logger.error(urlString)
                            Logger.error("=======PARAMETERS========")
                            Logger.error(parameters)
                            Logger.error("============ERROR=============")
                            Logger.error(error)
                            
                            observer.onError(error)
                        }
                    } else {
                        
                        Logger.error("======SEND POST REQUEST=======")
                        Logger.error(urlString)
                        Logger.warning("=======PARAMETERS========")
                        Logger.warning(parameters)
                        Logger.error("==========ERROR NIL============")
                        
                        observer.onError(ApiError.responseNil)
                    }
                case .failure(let error):
                    let errorException = self.getFailureError(statusCode: response.response?.statusCode, error: error)
                    observer.onError(errorException)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    public func requestPut<T: Codable, X: Codable>(
        urlString: String,
        parameters: X? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try! encoder.encode(parameters)
            
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue(AppConstant.APPLICATION_JSON, forHTTPHeaderField: AppConstant.CONTENT_TYPE)
            urlRequest.addValue("Bearer \(self.appKeychain.appToken())", forHTTPHeaderField: AppConstant.AUTHORIZATION)
            urlRequest.httpBody = data
           
            let request =  AF.request(urlRequest).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        do {
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(T.self, from: json)
        
                            Logger.info("======SEND POST REQUEST=======")
                            Logger.info(urlString)
                            Logger.info("===========RESPONSE===========")
                            Logger.info(response)
                            
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch let error {
                            
                            Logger.error("======SEND POST REQUEST=======")
                            Logger.error(urlString)
                            Logger.error("============ERROR=============")
                            Logger.error(error)
                            
                            observer.onError(error)
                        }
                    } else {
                        
                        Logger.error("======SEND POST REQUEST=======")
                        Logger.error(urlString)
                        Logger.error("==========ERROR NIL============")
                        
                        observer.onError(ApiError.responseNil)
                    }
                case .failure(let error):
                    let errorException = self.getFailureError(statusCode: response.response?.statusCode, error: error)
                    observer.onError(errorException)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func getFailureError(statusCode: Int?, error: Error) -> Error {
        switch statusCode {
        case 403:
            return ApiError.forbidden
        case 404:
            return ApiError.notFound
        case 409:
            return ApiError.conflict
        case 500:
            return ApiError.internalServerError
        default:
            return error
        }
    }
}
