import Foundation

print("Hello, Stylight111")

enum ServerCompass : String{
    case testing = "testing"
}
enum Router {
    static let baseURL = ServerCompass.testing.rawValue
}

print(Router.baseURL)
print("123123")