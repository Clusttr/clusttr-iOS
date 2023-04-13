//
//  ProfileView.swift
//  Lego
//
//  Created by Matthew Chukwuemeka on 13/04/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var searchWord = ""

    var body: some View {
        ZStack {
            header
                .overlay {
                    profileImage
                        .scaleEffect(0.8)
                        .padding(.bottom, 50)
                }
                .frame(height: 242)
                .frame(maxHeight: .infinity, alignment: .top)

            VStack {
                Text("Benjamin Ray")

                HStack {
                    Text("4.5")
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 11, height: 11)

                    Text("|")

                    Text("92")
                    Image(systemName: "heart.fill")
                }

                searchBar
                    .padding(20)

                Spacer()
            }
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.top, 210)

        }
        .background(.black)
    }

    var header: some View {
        Image.banner
            .resizable()
            .ignoresSafeArea()
            .mask {
                MyCustomShape()
            }
            .frame(height: 242)
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
    }

    var profileImage: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.05))
                .frame(width: 152, height: 152)

            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 152, height: 152)
                .overlay {
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                }
            Image
                .ape
                .resizable()
                .frame(width: 138, height: 138)
                .clipShape(Circle())
        }
    }

    var searchBar: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchWord)
                    .placeholder(when: searchWord.isEmpty) {
                        Text("Search")
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .accentColor(.red)
                    .foregroundColor(.white)
            }
            .foregroundColor(Color.white.opacity(0.7))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(height: 48)
            .background(.white.opacity(0.07))
            .cornerRadius(6)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white.opacity(0.3))
            }

            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white.opacity(0.7))
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0.6965*height))
        path.addLine(to: CGPoint(x: 0.93407*width, y: 0.71598*height))
        path.addCurve(to: CGPoint(x: 0.67476*width, y: 0.88187*height), control1: CGPoint(x: 0.84319*width, y: 0.74285*height), control2: CGPoint(x: 0.75547*width, y: 0.79896*height))
        path.addLine(to: CGPoint(x: 0.61076*width, y: 0.94762*height))
        path.addCurve(to: CGPoint(x: 0.39312*width, y: 0.93522*height), control1: CGPoint(x: 0.54238*width, y: 1.01787*height), control2: CGPoint(x: 0.45911*width, y: 1.01312*height))
        path.addLine(to: CGPoint(x: 0.38948*width, y: 0.93091*height))
        path.addCurve(to: CGPoint(x: 0.0689*width, y: 0.71361*height), control1: CGPoint(x: 0.29219*width, y: 0.81604*height), control2: CGPoint(x: 0.18284*width, y: 0.74193*height))
        path.addLine(to: CGPoint(x: 0, y: 0.6965*height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
