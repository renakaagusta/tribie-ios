//
//  NetworkRepository.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

import Alamofire
import SwiftyJSON
import RxSwift

class NetworkManager {
    private lazy var appKeychain = AppKeychain()
    
    enum ApiError: Error {
        case forbidden              //Status code 403
        case notFound               //Status code 404
        case conflict               //Status code 409
        case internalServerError    //Status code 500
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
    
    public func requestGetNoContentType<T: Codable>(urlString: String) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.request(urlString, method: .get, headers: [
                //AppConstant.CONTENT_TYPE : AppConstant.APPLICATION_JSON,
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
            let data = try! encoder.encode(parameters)
            
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
    
    
    public func requestDelete<T: Codable>(
        urlString: String
    ) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.request(urlString, method: .delete, headers: [
                AppConstant.CONTENT_TYPE: AppConstant.APPLICATION_JSON,
                AppConstant.AUTHORIZATION : "Bearer \(self.appKeychain.appToken())"
            ]).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        do {
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
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
    
    public func requestPostDocument<T: Codable>(
        urlString: String,
        datas: [String: Any]
    ) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.upload(multipartFormData: { (multipartFormData) in
                datas.forEach { (value) in
                    do {
                        if value.value is URL {
                            let splitDoc = (value.value as! URL).absoluteString.components(separatedBy: ".")
                            let typeDoc = splitDoc[splitDoc.count - 1]
                            multipartFormData.append(
                                try Data(contentsOf: (value.value as! URL)),
                                withName: value.key,
                                fileName: typeDoc == AppConstant.DOC_TYPE_PDF ? AppConstant.FILE_NAME_PDF : AppConstant.FILE_NAME_JPEG,
                                mimeType: typeDoc == AppConstant.DOC_TYPE_PDF ? AppConstant.MIME_PDF : AppConstant.MIME_IMAGE_JPEG)
                        } else if value.value is String {
                            multipartFormData.append((value.value as! String).data(using: .utf8)!, withName: value.key)
                        }
                    } catch let err {
                        observer.onError(err)
                    }
                }
            }, to: URL.init(string: urlString)!, usingThreshold: UInt64.init(), method: .post, headers: [
                AppConstant.AUTHORIZATION : "Bearer \(self.appKeychain.appToken())",
                AppConstant.CONTENT_TYPE: AppConstant.MULTIPART_FORM_DATA,
                AppConstant.CONTENT_DISPOSITION : AppConstant.FORM_DATA,
                AppConstant.ACCEPT : AppConstant.MIME_ALL
            ]).response { response in
                switch response.result {
                case .success(let value):
                    if let json = value {
                        let decoder = JSONDecoder()
                        do {
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
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
