//
//  NoriNetworkService+Extensions.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 30.10.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

//MARK: -
//MARK: Get

public func get<ModelType: NetworkProcessable>(
   with model: ModelType.Type
)
    -> Single<ModelType.ReturnedType>
{
   return get <| request(by: model)
}

public func get<ModelType: NetworkProcessable>(
   with request: Request<ModelType>
)
    -> Single<ModelType.ReturnedType>
{
   return single(with: request, method: <=|)
}

public func get<ModelType: NetworkProcessable>(
    with request: Request<ModelType>
)
    -> Completable
{
    return get(with: request).asCompletable()
}

//MARK: -
//MARK: Post

public func post<ModelType: NetworkProcessable>(
    with model: ModelType.Type
)
    -> Single<ModelType.ReturnedType>
{
   return post <| request(by: model)
}

public func post<ModelType: NetworkProcessable>(
   with request: Request<ModelType>
)
    -> Single<ModelType.ReturnedType>
{
   return single(with: request, method: |=>)
}

public func post<ModelType: NetworkProcessable>(
    with request: Request<ModelType>
)
    -> Completable
{
    return post(with: request).asCompletable()
}

//MARK: -
//MARK: Delete

public func delete<ModelType: NetworkProcessable>(
    with model: ModelType.Type
)
    -> Single<ModelType.ReturnedType>
{
   return delete <| request(by: model)
}

public func delete<ModelType: NetworkProcessable>(
   with request: Request<ModelType>
)
    -> Single<ModelType.ReturnedType>
{
   return single(with: request, method: !=>)
}


public func delete<ModelType: NetworkProcessable>(
    with request: Request<ModelType>
)
    -> Completable
{
    return delete(with: request).asCompletable()
}

//MARK: -
//MARK: Private

fileprivate func request<ModelType: NetworkProcessable>(
    by model: ModelType.Type
)
    -> Request<ModelType>
{
    return Request(modelType: model, url: model.url)
}

fileprivate func single<ModelType: NetworkProcessable>(
    with request: Request<ModelType>,
    method: @escaping (Request<ModelType>, @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>) -> Task?
)
    -> Single<ModelType.ReturnedType>
{
    return Single.create { single in
         let task = method(request) { result in
             switch result {
             case let .failure(error):
                 single(.error(error))
             case let .success(model):
                 single(.success(model))
             }
         }
         
         return Disposables.create {
             task?.cancel()
         }
     }
}
