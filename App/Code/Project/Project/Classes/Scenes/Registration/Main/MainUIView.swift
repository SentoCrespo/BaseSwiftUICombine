import SwiftUI

struct MainUIView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .purple
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Hey there")
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    Button(
                        action: {
                        print("Tapped")
                    }, label: {
                        Text("Tap me")
                    })
                    .buttonStyle(ButtonPrimaryStyle())
                }
            }
            .navigationBarTitle("Messages")
        }
    }
    
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
//            .previewLayout(
//                .fixed(width: 320, height: 70)
//            )
    }
}
