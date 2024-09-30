//
//  SupportView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 29/09/2024.
//

import SwiftUI

struct SupportView: View {
    var onClickMenu: () -> Void
    @State var urlDestination: URLDestination?

    enum URLDestination: String, Identifiable {
        case faqs, legal

        var id: String { self.rawValue }

        var url: URL {
            switch self {
                case .faqs: return URL(string: "https://www.clusttr.io")!
                case .legal: return URL(string: "https://www.clusttr.io/")!
            }
        }
    }

    var body: some View {
        VStack {
            Header(title: "Support", leadingView: {
                EmptyView()
            }, trailingView:  {
                Button("", systemImage: "line.3.horizontal", action: onClickMenu)
                    .foregroundColor(._grey100)
                    .fontWeight(.bold)
            })

            VStack(spacing: 24) {
                listItem(title: "Call us") {
                    callAdmin()
                }

                listItem(title: "Email us") {
                    openEmailApp(toEmail: "matthew.chukwuemeka40@gmail.com", subject: "Some Complaint", body: "Here we go")
                }

                listItem(title: "FAQs") {
                    urlDestination = .faqs
                }

                listItem(title: "Legal") {
                    urlDestination = .legal
                }
            }
            .foregroundColor(._grey100)
            .padding(.top, 32)
            .sheet(item: $urlDestination) { destination in
                WebView(url: destination.url)
            }

            Spacer()
            VStack() {
                Text("Stay up to date, Join our community.")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(._grey2)

                HStack {
                    Spacer()
                    ForEach(Socials.allCases) { social in
                        Button {

                        } label: {
                            Image(social.logoName)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color._grey100)
                                .padding(8)
                        }
                        Spacer()
                    }
                }
                .padding(.bottom, 110)
            }
        }
        .padding(.top, 50)
        .frame(maxWidth: .infinity)
        .background(Color._background)
    }

    @ViewBuilder
    func listItem(title: String, action: @escaping ()-> Void) -> some View {
        Button (action: action) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                Divider()
            }
            .padding(.horizontal, 16)
        }
    }

    func openEmailApp(toEmail: String, subject: String, body: String) {
        guard
            let subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let body = "Just testing ...".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {
            print("Error: Can't encode subject or body.")
            return
        }

        let urlString = "mailto:\(toEmail)?subject=\(subject)&body=\(body)"
        let url = URL(string:urlString)!

        UIApplication.shared.open(url)
    }

    func callAdmin() {
        let tel = "tel://+2348153132446"
        guard let url = URL(string: tel) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    SupportView() { }
}


import WebKit

struct WebView : UIViewRepresentable {
    @State var url: URL


    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
