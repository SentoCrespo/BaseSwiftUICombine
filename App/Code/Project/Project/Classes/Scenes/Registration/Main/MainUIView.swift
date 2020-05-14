import SwiftUI

struct MainUIView: View {
    
    // MARK: - Properties
//    @ObservedObject private(set) var model: MainModel.State
//    let render: MainSceneRender?
    
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

#if DEBUG
struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
#endif
