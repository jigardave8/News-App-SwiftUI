//
//  ContentView.swift
//  News App (SwiftUI)
//
//  Created by Jigar Dave on 9/10/23.
//




//Version 3.0
//import SwiftUI
//import SwiftyJSON
//import SDWebImageSwiftUI
//
//struct HomeView: View {
//    @ObservedObject var newsList = GetNewsData()
//    @State private var searchText = ""
//    @State private var isRefreshing = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                SearchBar(text: $searchText, placeholder: "Search News")
//                    .padding()
//
//                Button("Search") {
//                    self.isRefreshing = true
//                    self.newsList.searchNews(query: searchText) {
//                        self.isRefreshing = false
//                    }
//                }
//                .padding()
//
//                List {
//                    ForEach(newsList.newsDatas) { news in
//                        NavigationLink(destination: NewsDetailView(news: news)) {
//                            NewsRow(news: news)
//                        }
//                    }
//                }
//                .id(UUID()) // Ensure the list updates when searchText changes
//
//                if isRefreshing {
//                    ProgressView("Refreshing...")
//                        .padding()
//                }
//            }
//            .navigationBarTitle("News", displayMode: .inline)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
//
//struct NewsDetailView: View {
//    var news: NewsDataType
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                if news.image != "" {
//                    WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(12)
//                        .padding(.bottom, 16)
//                }
//
//                Text(news.title)
//                    .font(.title)
//                    .bold()
//
//                Text(news.description)
//                    .font(.body)
//                    .padding(.bottom, 16)
//
//                Text("Source: \(news.source)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Text("Published At: \(news.publishedAt)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            .padding()
//        }
//        .navigationBarTitle(Text("News Detail"), displayMode: .inline)
//    }
//}
//
//struct NewsRow: View {
//    var news: NewsDataType
//
//    var body: some View {
//        HStack {
//            if news.image != "" {
//                WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
//                    .resizable()
//                    .frame(width: 70, height: 70, alignment: .center)
//                    .aspectRatio(contentMode: .fill)
//                    .cornerRadius(12)
//            }
//
//            VStack(alignment: .leading, spacing: 6) {
//                Text(news.title)
//                    .font(.headline)
//                    .lineLimit(2)
//
//                Text(news.description)
//                    .font(.subheadline)
//                    .lineLimit(2)
//
//                Text("Source: \(news.source)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Text("Published At: \(news.publishedAt)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            .padding()
//        }
//    }
//}
//
//struct SearchBar: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.gray)
//            TextField(placeholder, text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
//                .disableAutocorrection(true)
//        }
//    }
//}
//
//// MARK: New API Integration - Get Data from resource
//struct NewsDataType: Identifiable {
//    var id: String
//    var title: String
//    var description: String
//    var image: String
//    var url: String
//    var source: String
//    var publishedAt: String
//}
//
//class GetNewsData: ObservableObject {
//    @Published var newsDatas = [NewsDataType]()
//
//    init() {
//        fetchNews()
//    }
//
//    func fetchNews() {
//        // Replace with your API key and URL
//        let apiKey = "90eaa6ce6605476bbddf39c74ba34bd5"
//        let sourceOfNews = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=90eaa6ce6605476bbddf39c74ba34bd5"
//
//        guard let url = URL(string: sourceOfNews) else {
//            return
//        }
//
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if let data = data {
//                let json = try? JSON(data: data)
//                for index in json?["articles"] ?? JSON([]) {
//                    let id = index.1["publishedAt"].stringValue
//                    let title = index.1["title"].stringValue
//                    let description = index.1["description"].stringValue
//                    let image = index.1["urlToImage"].stringValue
//                    let url = index.1["url"].stringValue
//                    let source = index.1["source"]["name"].stringValue
//                    let publishedAt = index.1["publishedAt"].stringValue
//
//                    DispatchQueue.main.async {
//                        self.newsDatas.append(NewsDataType(id: id, title: title, description: description, image: image, url: url, source: source, publishedAt: publishedAt))
//                    }
//                }
//            }
//        }.resume()
//    }
//
//    func searchNews(query: String, completion: @escaping () -> Void) {
//        let apiKey = "90eaa6ce6605476bbddf39c74ba34bd5"
//        let searchURL = "https://newsapi.org/v2/everything?apiKey=\("90eaa6ce6605476bbddf39c74ba34bd5")&q=\(query)&pageSize=20"  // You can adjust the pageSize as needed
//
//        guard let url = URL(string: searchURL) else {
//            completion()
//            return
//        }
//
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//                completion()
//                return
//            }
//
//            if let data = data {
//                let json = try? JSON(data: data)
//                self.newsDatas.removeAll() // Clear existing data
//
//                for index in json?["articles"] ?? JSON([]) {
//                    let id = index.1["publishedAt"].stringValue
//                    let title = index.1["title"].stringValue
//                    let description = index.1["description"].stringValue
//                    let image = index.1["urlToImage"].stringValue
//                    let url = index.1["url"].stringValue
//                    let source = index.1["source"]["name"].stringValue
//                    let publishedAt = index.1["publishedAt"].stringValue
//
//                    DispatchQueue.main.async {
//                        self.newsDatas.append(NewsDataType(id: id, title: title, description: description, image: image, url: url, source: source, publishedAt: publishedAt))
//                    }
//                }
//            }
//
//            completion()
//        }.resume()
//    }
//
//}




import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI


//Version 2.0
struct HomeView: View {
    @ObservedObject var newsList = GetNewsData()
    @State private var searchText = ""
    @State private var isRefreshing = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search News")
                    .padding()

                List {
                    ForEach(newsList.filteredNews(searchText: searchText)) { news in
                        NavigationLink(destination: NewsDetailView(news: news)) {
                            NewsRow(news: news)
                        }
                    }
                }
                .id(UUID()) // Ensure list updates when searchText changes

                if isRefreshing {
                    ProgressView("Refreshing...")
                        .padding()
                }
            }
            .navigationBarTitle("News", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Add any additional refreshing logic here if needed
                self.isRefreshing = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRefreshing = false
                }
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(.blue)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct NewsDetailView: View {
    var news: NewsDataType

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if news.image != "" {
                    WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .padding(.bottom, 16)
                }

                Text(news.title)
                    .font(.title)
                    .bold()

                Text(news.description)
                    .font(.body)
                    .padding(.bottom, 16)

                Text("Source: \(news.source)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Published At: \(news.publishedAt)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .navigationBarTitle(Text("News Detail"), displayMode: .inline)
    }
}

struct NewsRow: View {
    var news: NewsDataType

    var body: some View {
        HStack {
            if news.image != "" {
                WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(12)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(news.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(news.description)
                    .font(.subheadline)
                    .lineLimit(2)

                Text("Source: \(news.source)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text("Published At: \(news.publishedAt)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}

// MARK: New API Integration. - Get Data from resource.
//
struct NewsDataType: Identifiable {
    var id: String
    var title: String
    var description: String
    var image: String
    var url: String
    var source: String
    var publishedAt: String
}

class GetNewsData: ObservableObject {
    @Published var newsDatas = [NewsDataType]()

    init() {
        // Paste in your API URL from https://newsapi.org/v2/everything
        //
        let sourceOfNews = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=90eaa6ce6605476bbddf39c74ba34bd5"

        guard let url = URL(string: sourceOfNews) else {
            return
        }

        let session = URLSession(configuration: .default)

        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                let json = try? JSON(data: data)
                for index in json?["articles"] ?? JSON([]) {
                    let id = index.1["publishedAt"].stringValue
                    let title = index.1["title"].stringValue
                    let description = index.1["description"].stringValue
                    let image = index.1["urlToImage"].stringValue
                    let url = index.1["url"].stringValue
                    let source = index.1["source"]["name"].stringValue
                    let publishedAt = index.1["publishedAt"].stringValue

                    DispatchQueue.main.async {
                        self.newsDatas.append(NewsDataType(id: id, title: title, description: description, image: image, url: url, source: source, publishedAt: publishedAt))
                    }
                }
            }
        }.resume()
    }
}

extension GetNewsData {
    func filteredNews(searchText: String) -> [NewsDataType] {
        if searchText.isEmpty {
            return newsDatas
        } else {
            return newsDatas.filter { news in
                news.title.lowercased().contains(searchText.lowercased()) ||
                    news.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
}






//MARK: New API Integration. - Get Data from resource.
// Version 1.5
//struct NewsDataType: Identifiable {
//    var id: String
//    var title: String
//    var description: String
//    var image: String
//    var url: String
//}
//
//class GetNewsData: ObservableObject {
//    @Published var newsDatas = [NewsDataType]()
//    
//    init() {
//        //Paste in variable source our URL from https://newsapi.org/docs/endpoints/top-headlines
//        let sourceOfNews = "https://newsapi.org/v2/top-headlines?country=us&apiKey=405d28de2e87403b98106f5dbebd9878"
//        
//        let url = URL(string: sourceOfNews)!
//        
//        let session = URLSession(configuration: .default)
//        
//        session.dataTask(with: url) {
//            (data, _, error) in
//            
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            
//            let json = try! JSON(data: data!)
//            
//            for index in json["articles"] {
//                let id = index.1["publishedAt"].stringValue
//                let title = index.1["title"].stringValue
//                let description = index.1["description"].stringValue
//                let image = index.1["urlToImage"].stringValue
//                let url = index.1["url"].stringValue
//                
//                DispatchQueue.main.async {
//                    self.newsDatas.append(NewsDataType(id: id, title: title, description: description, image: image, url: url))
//                }
//            }
//        }.resume()
//    }
//}




// ORIGINAL SOURCE CODE *1
//import SwiftUI
//import SwiftyJSON
//import SDWebImageSwiftUI
//
//struct HomeView: View {
//    @ObservedObject var newsList = GetNewsData()
//    
//    var body: some View {
//        NavigationView {
//            List(newsList.newsDatas) { index in
//                HStack {
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text(index.title)
//                            .font(.body)
//                            .lineLimit(2)
//                        
//                        Text(index.description)
//                            .font(.subheadline)
//                            .lineLimit(2)
//                    }
//                    .padding()
//                }
//                
//                if index.image != "" {
//                    WebImage(url: URL(string: index.image), options: .highPriority, context: nil)
//                        .resizable()
//                        .frame(width: 70, height: 70, alignment: .center)
//                        .aspectRatio(contentMode: .fill)
//                        .cornerRadius(12)
//                }
//            }
//            .navigationBarTitle(Text("News"))
//            .font(.title)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

//MARK: FOR DETAIL VIEW INTEGRATED OPTION

/*
 import SwiftUI
 import SwiftyJSON
 import SDWebImageSwiftUI

 struct HomeView: View {
     @ObservedObject var newsList = GetNewsData()

     var body: some View {
         NavigationView {
             List(newsList.newsDatas) { news in
                 NavigationLink(destination: NewsDetailView(news: news)) {
                     HStack {
                         if news.image != "" {
                             WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
                                 .resizable()
                                 .frame(width: 70, height: 70, alignment: .center)
                                 .aspectRatio(contentMode: .fill)
                                 .cornerRadius(12)
                         }

                         VStack(alignment: .leading, spacing: 6) {
                             Text(news.title)
                                 .font(.body)
                                 .lineLimit(2)

                             Text(news.description)
                                 .font(.subheadline)
                                 .lineLimit(2)
                         }
                         .padding()
                     }
                 }
             }
             .navigationBarTitle(Text("News"))
             .font(.title)
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         HomeView()
     }
 }

 struct NewsDetailView: View {
     var news: NewsDataType

     var body: some View {
         VStack(alignment: .leading, spacing: 16) {
             if news.image != "" {
                 WebImage(url: URL(string: news.image), options: .highPriority, context: nil)
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .cornerRadius(12)
                     .padding(.bottom, 16)
             }

             Text(news.title)
                 .font(.title)
                 .bold()

             Text(news.description)
                 .font(.body)
                 .padding(.bottom, 16)

             Link("Read More", destination: URL(string: news.url)!)
                 .foregroundColor(.blue)
         }
         .padding()
         .navigationBarTitle(Text("News Detail"), displayMode: .inline)
     }
 }
 */



