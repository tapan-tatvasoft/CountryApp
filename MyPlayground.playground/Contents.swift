import UIKit
import SwiftUI
var greeting = "Hello, playground"


//@main
//struct mainApp {
//    // creating a view model
//    ProductListViewModel(viewModel: ProductListViewModel())
//    
//    
//}
//
//
//// ViewModel
//
//class ProductListViewModel: ObservableObject {
//    @Published var products: [Product] = []
//    
//    
//    func getProducts() async {
//        do {
//            products = try await NetwrokManager.shared.getProducts()
//
//        } catch {
//            
//        }
//    }
//}
//
//// Views
//struct ProductListView: View {
//  //  @StateObject var viewModel = ProductListViewModel()
//    
//    
//    @ObservedObject var viewModel: ProductListViewModel
//    // navigating to product details
//        .onAppear {
//            Task {
//                await viewModel.getProducts()
//            }
//        }
//    
//}
//
//// Models
//struct Product {
//    let produtctID: Int
//    let productNAme: String
//}
//
//// Network Manager
//// APIs
//
//
//struct viewModifier: viewModifier {
//    var body(content: Content): some view {
//        
//    }
//}
//
//extension View {
//    
//    
//}


//extension Array {
//    
//    func getUniqueItems() -> [T] {
//        
//        var uniqueItem = Set<T>()
//        
//        for i in self. {
////            if !uniqueItem.contains(i) {
//                uniqueItem.insert(i)
////            }
//        }
//        
//        return Array(uniqueItem)
//    }
//    
//}

struct User {
    let email: String
    let phoneNumber: String
}

let user1 = User(email: "abc", phoneNumber: "123455678")
let user2 = User(email: "abc1", phoneNumber: "1234556789")
let user3 = User(email: "abc2", phoneNumber: "1234556788")
let user4 = User(email: "abc3", phoneNumber: "1234556787")
let user5 = User(email: "abc4", phoneNumber: "1234556786")
let user6 = User(email: "abc5", phoneNumber: "1234556785")

let userList = [[user1, user2], [user3, user4], [user5, user6]]

print(userList.flatMap { $0.map { $0.email}})

//
//
//
//compactMap {
//
//}

//print(userList.flatMap { }. map { $0.email} )




var items = [1,2,3,1,4,6,7]
//var stringArray = ["a","a","b"]
//
//print(getEvenNumbers(items))

extension Array where Element : Hashable {
    func unique() -> [Element] {
        Array(Set(self))
    }
    
    func uniqueWithOrder() -> [Element] {
        var seen = Set<Element>()
        return self.filter { seen.insert($0).inserted }
    }
}

print(items.unique())
print(items.uniqueWithOrder())
