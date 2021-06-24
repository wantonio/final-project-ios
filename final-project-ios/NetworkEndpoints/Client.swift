import Foundation

class Client: NetworkGeneric {
    let baseUrlStr = "https://api.spoonacular.com/"
    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]!
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func search(queryParams: SearchQueryParam, complete: @escaping (Result<SearchRes, ApiError>) -> Void) {
        let newQueryParams = ["apiKey": apiKey]
            .merging(queryParams.dictonaryDefault) {(dictionayOne, _) in dictionayOne}
            .toQueryParam()!
        
        let url = URL(string: "\(baseUrlStr)recipes/complexSearch?\(newQueryParams)")!
        let request = URLRequest(url: url)
        self.fetch(type: SearchRes.self, with: request, completion: complete)
    }
    
    func getRecipe(id: Int, complete: @escaping (Result<RecipeInfo, ApiError>) -> Void) {
        let newQueryParams = ["apiKey": apiKey, "includeNutrition": true].toQueryParam()!
        let url = URL(string: "\(baseUrlStr)recipes/\(id)/information?\(newQueryParams)")!
        let request = URLRequest(url: url)
        self.fetch(type: RecipeInfo.self, with: request, completion: complete)
    }
}
