import SwiftUI
import Combine

struct MainUIView: View {
    
    // MARK: - Properties
    private let viewModel: MainViewModel
//    let render: MainSceneRender?
    
    // TODO: Inject properties
    init() {
        self.viewModel = MainViewModel()
    }
    
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
                            self.viewModel.send(action: .onSelect("Tapped"))
                    }, label: {
                        Text("Tap me")
                    })
                    .buttonStyle(ButtonPrimaryStyle())
                }
            }
            .navigationBarTitle("Messages")
        }
        .onAppear {
            self.viewModel.send(action: .onAppear)
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
