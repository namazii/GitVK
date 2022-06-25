  //
//  AuthVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.06.2022.
//

import UIKit
import WebKit

class AuthVC: UIViewController {

    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.navigationDelegate = self
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        
        if Session.isTokenValid {
            // Переход на следующий контроллер
            let mainTabVC = MainTabVC()
            navigationController?.pushViewController(mainTabVC, animated: true)
            navigationController?.isNavigationBarHidden = true
            return
        }
        
        authorizeToVK()
    }
    
    func authorizeToVK() {
        
        //https://oauth.vk.com/authorize?client_id=1&display=page&redirect_uri=http://example.com/callback&scope=friends&response_type=code&v=5.131
        
        // конструктор URL - URLComponents ( ascii, persent encoding )
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "redirect_uri",
                         value: "https://oauth.vk.com/blank.html"
                        ),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "271390"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1")
        ]
            
            guard let url = urlComponents.url else { return }
            
            let request =  URLRequest(url: url)
            webView.load(request)
    }
    
    func loadUrl() {
        guard let url = URL(string: "https://www.apple.com") else { return }
        if let data = try? Data(contentsOf: url) {
            let request = URLRequest(url: url)
            webView.load(data,
                         mimeType: "application/pdf",
                         characterEncodingName: "",
                         baseURL: url
            )
        }
    }
    
    func setupViews() {
        view.addSubview(webView)
    }
    
    func setupConstrains() {
        webView.pinEdgesToSuperView()
    }
}

extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        //https://oauth.vk.com/blank.html#access_token=533bacf01e11f55b536a565b57531ad114461ae8736d6506a3&expires_in=86400&user_id=8492&state=123456

        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {

            //Продолжить слушать запросы браузера
            decisionHandler(.allow)
            return
        }

        print(url)

        let params: Dictionary<String, String> = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { partialResult, array in
                
                var dictionary = partialResult
                let key = array[0]
                let value = array[1]
                dictionary[key] = value
                return dictionary
            }

        guard let token = params["access_token"], let userId = params["user_id"], let expiresIn = params["expires_in"] else { return }

        Session.shared.accessToken = token
        Session.shared.userid = Int(userId) ?? 0
        Session.shared.expiresIn = Int(expiresIn) ?? 0

        // Переход на следующий контроллер
        let mainTabVC = MainTabVC()
        navigationController?.pushViewController(mainTabVC, animated: true)
        navigationController?.isNavigationBarHidden = true
    
        decisionHandler(.cancel)
    }
}

