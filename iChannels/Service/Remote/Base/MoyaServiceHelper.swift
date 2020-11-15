//
//  ServiceHelper.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/10/20.
//

import Moya

class MoyaServiceHelper<T: TargetType>
{
    // MARK:- Properties
    
    private var provider: MoyaProvider<T>
    
    // MARK:- Init
    
    init(type: ServiceType)
    {
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure =
            { (activity, _) in
                
                switch activity
                {
                    case .began:
                        ActivityIndicator.startLoading()
                        
                    case .ended:
                        ActivityIndicator.stopLoading()
                }
            }
        
        var plugins: [PluginType] = []
        
        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        plugins.append(networkActivityPlugin)
        
        let networkLogger = NetworkLoggerPlugin()
        plugins.append(networkLogger)
        
        let serviceType = type == .live ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        
        self.provider = MoyaProvider<T>(stubClosure: serviceType, plugins: plugins)
    }
    
    // MARK:- Methods
    
    func request<C: Codable>(targetCase: T,
                             completion: @escaping (Result<BaseAPIResponse<C>,
                                                           NetworkError>) -> Void)
    {
        provider.request(targetCase) { result in
            switch result
            {
                case let .success(value):
                    
                    guard value.statusCode.isValidAsStatusCode else
                    {
                        completion(.failure(.init(value.statusCode)))
                        return
                    }
                    
                    do
                    {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(BaseAPIResponse<C>.self, from: value.data)
                        completion(.success(response))
                    }
                    catch(let error)
                    {
                        completion(.failure(.init(error)))
                    }
                
                case let .failure(error):
                    completion(.failure(.init(error)))
            }
        }
    }
}
