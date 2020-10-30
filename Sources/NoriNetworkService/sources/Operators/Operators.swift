//
//  Operators.swift
//  Network Service
//
//  Created by IDAP Developer on 12/3/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import Foundation

infix operator <=|: DefaultPrecedence // GET
infix operator |=>: DefaultPrecedence // POST
infix operator !=>: DefaultPrecedence // DEL
infix operator =>>: DefaultPrecedence // PUT

@discardableResult
public func <=| <ModelType: NetworkProcessable, ServiceType>(
    request: Request<ModelType>,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ModelType.Service == ServiceType
{
    return task(request: request, modelHandler: modelHandler, requestType: .get)
}

@discardableResult
public func <=| <ModelType: NetworkProcessable, ServiceType>(
    model: ModelType.Type,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ServiceType == ModelType.Service
{
    return Request<ModelType>(modelType: model, url: model.url) <=| modelHandler
}

@discardableResult
public func =>> <ModelType: NetworkProcessable, ServiceType>(
    request: Request<ModelType>,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ModelType.Service == ServiceType
{
    return task(request: request, modelHandler: modelHandler, requestType: .put)
}

@discardableResult
public func =>> <ModelType: NetworkProcessable, ServiceType>(
    model: ModelType.Type,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ServiceType == ModelType.Service
{
    return Request<ModelType>(modelType: model, url: model.url) =>> modelHandler
}

@discardableResult
public func !=> <ModelType: NetworkProcessable, ServiceType>(
    request: Request<ModelType>,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ModelType.Service == ServiceType
{
    return task(request: request, modelHandler: modelHandler, requestType: .delete)
}

@discardableResult
public func !=> <ModelType: NetworkProcessable, ServiceType>(
    model: ModelType.Type,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ServiceType == ModelType.Service
{
    return Request<ModelType>(modelType: model, url: model.url) !=> modelHandler
}

@discardableResult
public func |=> <ModelType: NetworkProcessable, ServiceType>(
    request: Request<ModelType>,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ModelType.Service == ServiceType
{
    return task(request: request, modelHandler: modelHandler, requestType: .post)
}

@discardableResult
public func |=> <ModelType: NetworkProcessable, ServiceType>(
    model: ModelType.Type,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>
) -> Task?
    where ServiceType == ModelType.Service
{
    return Request<ModelType>(modelType: model, url: model.url) |=> modelHandler
}

private func task<ModelType: NetworkProcessable, ServiceType>(
    request: Request<ModelType>,
    modelHandler: @escaping ModelHandler<Result<ModelType.ReturnedType, Error>>,
    requestType: RequestType
) -> Task?
     where ServiceType == ModelType.Service
{
    var mutable = request
    
    mutable.type = requestType
    
    let data = (ServiceType.self *| mutable)
    
    data.0.handler = { result in
        modelHandler(ModelType.initialize(with: result))
    }
    
    data.0.task?.resume()
    
    return data.0.task
}

infix operator *| // Combine model/request with service

@discardableResult
public func *| <Session: SessionService, Model: NetworkProcessable> (
    session: Session.Type,
    request: Request<Model>
)
    -> NetworkOperationComposingResult<Model.DataType, Model.Type> where Session.DataType == Model.DataType
{
    let handlerContainer = TaskExecutableDataHandler<Model.DataType>(handler: nil, task: nil)
    
    let task = session.dataTask(request: request) {
        handlerContainer.handler?($0)
    }
    
    handlerContainer.task = task
    
    return (handlerContainer, Model.self)
}

infix operator +| // Combine request with query params
public func +| <ModelType, Params: QueryParamsType>(model: ModelType.Type, params: Params) -> Request<ModelType>
    where ModelType: NetworkProcessable
{
    let encoder = JSONEncoder()
    let data = (try? encoder.encode(params)) ?? Data()
    
    let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String : Any]
    
    let url = model.url +? (dictionary ?? [:])
    
    return Request(modelType: model, url: url)
}

public func +| <ModelType, Params: BodyParamsType>(model: ModelType.Type, params: Params) -> Request<ModelType>
    where ModelType: NetworkProcessable
{
    let encoder = JSONEncoder()
    
    let data = (try? encoder.encode(params)) ?? Data()
    
    var dictionary = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String : Any]
    dictionary?.merge(params.rawValues) { (_, new) in new }
    
    let encoded = dictionary?.multipartRequestConverted() ?? Data()
    
    let url = model.url
    
    return Request(modelType: model, url: url, body: encoded)
}

public func +| <ModelType>(model: ModelType.Type, pathParam: String) -> Request<ModelType>
    where ModelType: NetworkProcessable
{
    let url = model.url + pathParam
    
    return Request(modelType: model, url: url)
}

public func multipleParamRequest<ModelType, Params: QueryParamsType>(model: ModelType.Type, pathParam: String, queryParams: Params) -> Request<ModelType>
    where ModelType: NetworkProcessable
{
    let encoder = JSONEncoder()
    let data = (try? encoder.encode(queryParams)) ?? Data()
    
    let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String : Any]
    
    let url = (model.url + pathParam) +? (dictionary ?? [:])
    
    return Request(modelType: model, url: url)
}

//MARK: -
//MARK: Pipe-forward

infix operator |>: AdditionPrecedence
infix operator ||>: AdditionPrecedence

public func |> <A, Result>(value: A, transform: @escaping (A) -> Result) -> Result {
    return transform(value)
}

public func |> <A, Result>(value: A, transform: @escaping (A) throws -> Result) -> Result? {
    return try? transform(value)
}

public func ||> <A, B, Result>(value: (A, B), transform: @escaping (A) -> (B) -> Result) -> Result {
    let (a, b) = value
    
    return transform(a)(b)
}

public func ||> <A, B, Result>(value: (A, B), transform: @escaping (A, B) -> Result) -> Result {
    let (a, b) = value
    
    return transform(a, b)
}

//MARK: -
//MARK: Optional Pipe-forward

infix operator ?|>: AdditionPrecedence
infix operator <|?: AdditionPrecedence

public func ?|> <A, Result>(value: A?, transform: ((A) -> Result)?) -> Result? {
    return value.apply(transform)
}

public func <|? <A, Result>(transform: ((A?) -> Result)?, value: A?) -> Result? {
    return transform?(value)
}

public func <|? <A, Result>(transform: ((A) -> Result)?, value: A?) -> Result? {
    return value.apply(transform)
}

//MARK: -
//MARK: Pipe-backward

infix operator <|: AdditionPrecedence
infix operator <||: AdditionPrecedence
infix operator <||?: AdditionPrecedence

public func <| <A, Result>(transform: @escaping (A) -> Result, value: A) -> Result {
    return value |> transform
}

public func <|| <A, B, Result>(transform: @escaping (A) -> (B) -> Result, value: (A, B)) -> Result {
    return value ||> transform
}

public func <|| <A, B, Result>(transform: @escaping (A, B) -> Result, value: (A, B)) -> Result {
    return value ||> transform
}

public func <|| <A, B, C, Result>(transform: @escaping (A, B, C) -> Result, value: (A, B, C)) -> Result {
    return transform(value.0, value.1, value.2)
}

public func <||? <A, B, Result>(transform: ((A, B) -> Result)?, value: (A, B)) -> Result? {
    return transform?(value.0, value.1)
}

//MARK: -
//MARK: Composition

infix operator •: MultiplicationPrecedence

public func • <A, B, C>(f1: @escaping (A) -> B, f2: @escaping (B) -> C) -> (A) -> C {
    return { f1($0) |> f2 }
}

//MARK: -
//MARK: Curry and uncarry

postfix operator <>

public postfix func <> <A, B, C, D, E>(f: @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { a in { b in { c in { d in f(a, b, c, d) } } } }
}

public postfix func <> <A, B, C, D, E, F>(f: @escaping (A, B, C, D, E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    return { a in { b in { c in { d in { e in f(a, b, c, d, e) } } } } }
}

public postfix func <> <A, B, C, D>(f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in
        { b in { f(a, b, $0) } }
    }
}

public postfix func <> <A, B, C>(f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        { f(a, $0) }
    }
}

postfix operator ><

public postfix func >< <A, B, C>(f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { ($0, $1) ||> f }
}

//MARK: -
//MARK: Partial application

infix operator <|>: MultiplicationPrecedence

public func <|> <A, B, C>(f: @escaping (A, B) -> C, value: A) -> (B) -> C {
    return value |> f<>
}

//MARK: Funcs

public func flip<A, B, Result>(_ f: @escaping (A, B) -> Result) -> (B, A) -> Result {
    return { f($1, $0) }
}

public func flip<A, B, C, Result>(_ f: @escaping (A, B, C) -> Result) -> (C, B, A) -> Result {
    return { f($2, $1, $0) }
}

public func flatten<Value>(_ value: Value??) -> Value? {
    return value.flatMap { $0 }
}
