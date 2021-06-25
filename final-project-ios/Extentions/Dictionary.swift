import Foundation

extension Dictionary {
    func toQueryParam() -> String? {
        return map {key, value in
            let key = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let value = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            return "\(key)=\(value)"
        }.joined(separator: "&")
    }
}
