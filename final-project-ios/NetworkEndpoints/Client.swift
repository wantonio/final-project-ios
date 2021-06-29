import Foundation
import JSONLoader

class Client: NetworkGeneric {
    let baseUrlStr = "https://api.spoonacular.com/"
    var session: URLSession
    
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'API-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'API-Info.plist'.")
        }
        return value
      }
    }
    
    private var isDevelopment: Bool {
      get {
        guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'API-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "DEVELOPMENT") as? Bool else {
          fatalError("Couldn't find key 'DEVELOPMENT' in 'API-Info.plist'.")
        }
        return value
      }
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(queryParams: SearchQueryParam, complete: @escaping (Result<SearchRes, ApiError>) -> Void) {
        if isDevelopment {
            do {
                let search:SearchRes = try loadFromBundle("search")
                complete(.success(search))
            } catch let err {
                complete(.failure(.requestFailed(description: err.localizedDescription)))
            }
            
            return
        }
        
        let newQueryParams = ["apiKey": apiKey]
            .merging(queryParams.dictonaryDefault) {(dictionayOne, _) in dictionayOne}
            .toQueryParam()!
        
        let url = URL(string: "\(baseUrlStr)recipes/complexSearch?\(newQueryParams)")!
        let request = URLRequest(url: url)
        self.fetch(type: SearchRes.self, with: request, completion: complete)
    }
    
    func getRecipe(id: Int, complete: @escaping (Result<RecipeInfo, ApiError>) -> Void) {
        if isDevelopment {
            do {
                let recipe:RecipeInfo = try loadFromBundle("recipe")
                complete(.success(recipe))
            } catch let err {
                complete(.failure(.requestFailed(description: err.localizedDescription)))
            }
            
            return
        }
        
        let newQueryParams = ["apiKey": apiKey, "includeNutrition": true].toQueryParam()!
        let url = URL(string: "\(baseUrlStr)recipes/\(id)/information?\(newQueryParams)")!
        let request = URLRequest(url: url)
        self.fetch(type: RecipeInfo.self, with: request, completion: complete)
    }
}
