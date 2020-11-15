//
//  UserSessionManager.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/25/20.
//

import Foundation

class UserSessionManager
{
    // MARK: Properties
    
    public static var instance = UserSessionManager()
    
    private(set) var user: User?
    {
        get
        {
            guard let data = UserDefaults.standard.data(forKey: WajeezKeys.User.currentUser.rawValue) else { return nil }
            
            return try? JSONDecoder().decode(User.self, from: data)
        }
        set
        {
            if let data = try? JSONEncoder().encode(newValue)
            {
                UserDefaults.standard.set(data, forKey: WajeezKeys.User.currentUser.rawValue)
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: WajeezKeys.User.currentUser.rawValue)
            }
            
            UserDefaults.standard.synchronize()
        }
    }
    
    private(set) var token: String?
    {
        get
        {
            //let key = WajeezKeys.User.deviceToken.rawValue
            //return UserDefaults.standard.string(forKey: key)
            
            #warning("Testing")
            
            let testingToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImM2MDZiM2IyN2M3NmVmODhiZjA3Yjc3Yjc3YjA2OTRhNzZiYTFlNjA0NzE3MGExODFkZmRmMDZlZmI3NjlhMzc5NTdhMmQ3MmZjNzBkZDdiIn0.eyJhdWQiOiIxIiwianRpIjoiYzYwNmIzYjI3Yzc2ZWY4OGJmMDdiNzdiNzdiMDY5NGE3NmJhMWU2MDQ3MTcwYTE4MWRmZGYwNmVmYjc2OWEzNzk1N2EyZDcyZmM3MGRkN2IiLCJpYXQiOjE2MDUxNzU3MzEsIm5iZiI6MTYwNTE3NTczMSwiZXhwIjoxNjM2NzExNzMxLCJzdWIiOiIxNzIzOTUiLCJzY29wZXMiOltdfQ.HjbWXPnSLRCYA-sLiDfMXSol15_aLb8LBmsDmeK5kspF9ppgSQfjT8bqeqtJ3OvJizwlNjFPefx_hLX13wdzczpuTEb-8tk8-bxPsEF4LWMWTjobNpUEd0IV2nGc42e4T9qPGYB5ddT-kejX-bXWEUJqghYHDMcvlxBMnj48j_wKU3SfdJ0PqSt7qeJrx9caH395TrC0TIVd-0aUPAUzQVXefZNu6EM4oN4P7ipG6X8x8-OTIsKklTDSNwBFtauHkYaAymNCO8gVE2X6KbtZ_SICqqlOhoEcyFureOJWK5fi7jhK_ziTfK2qUEo1PzcRwfBOETX40x-BV2k2Xxo5hbo0nRhDX_NNbSo6KK73ye1nBCln4v4EwWv367YYj_1VGWAdHaytvUHDSszhfU-XK1HC6TnviCNgsiIoGdW2H-fNJ_7SZiCyM_mIcdtJYQK68HBl4UhcdzkwvKIXRQ6Zk_lFTj3P3F-5gKWGLphMydG1UhlIUvibf9PtoDhqfuLWkYIFifBeRyV7iE2zZU0GcUURIBl1uv8MN_uDla-CoFQQ6C80vtEOK0uQHMg82AKbmTUosrPODF8XTFE6EFk9uDace2w8phVf0Lex8KNTC47bkZnylNjADhd8VlBakAa5XuxlW9Fz4FWnlQozscsT0dvt9zkjNFYK5NLN6mTT3NI"
            
            return testingToken
        }
        set
        {
            let key = WajeezKeys.User.deviceToken.rawValue
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    var hasSubscriptionProgram: Bool
    {
        if let _ = user?.subscription
        {
            return true
        }
        
        return false
    }
    
    var isLoggedIn: Bool
    {
        if let _ = user
        {
            return true
        }
        
        return false
    }
    
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    func setUser(_ user: User)
    {
        self.user = user
    }
    
    func setUserData(user: User, token: String)
    {
        self.user = user
        self.token = token
    }
    
    func removeUser()
    {
        self.user = nil
    }
}
