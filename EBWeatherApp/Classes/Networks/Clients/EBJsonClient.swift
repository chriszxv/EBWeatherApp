//
//  EBJsonClient.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

import RxCocoa
import RxSwift

final class EBJsonClient {
    static func send<T: Codable>(_ apiRequest: EBBaseRequest, delegate: URLSessionDelegate? = nil) -> Observable<T> {
        return Observable<T>.create { observer in

            let request = apiRequest.request()

            if let urlString = request.url?.absoluteString {
                print("[Request] Start JSON request: " + urlString)
            }

            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = 12.0
            let session = URLSession(configuration: sessionConfig,
                                     delegate: delegate,
                                     delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { data, _, error in

                if let responseError = error {
                    print("[Response] JSON response error: " + responseError.localizedDescription)
                    observer.onError(responseError)
                } else {
                    do {
                        let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                        observer.onNext(model)
                    } catch let decodeError {
                        print("[Response] JSON decode error: " + decodeError.localizedDescription)
                        observer.onError(decodeError)
                    }
                }
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
