import SwiftUI
import Combine

/// UI layer to display the scene
struct MainUIView: View {
    
    // MARK: - Properties
    @ObservedObject private var viewModel: MainViewModel
    let render: MainSceneRender?
    
    // MARK: Life Cycle
    init(render: MainSceneRender, viewModel: MainViewModel) {
        self.render = render
        self.viewModel = viewModel
    }

}

// MARK: - UI definition
extension MainUIView {
    var body: some View {
        NavigationView {
          VStack(spacing: 0) {
            self.content
            Spacer()
          }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.apply(event: .onAppear)
            }
        }
//        NavigationView {
//            ZStack {
//                Color
//                    .purple
//                    .edgesIgnoringSafeArea(.all)
//                VStack {
//                    Text("Hey there")
//                        .font(.title)
//                        .foregroundColor(.primary)
//
//                    Button(
//                        action: {
//                            self.viewModel.apply(event: .onSelect("Tapped"))
//                    }, label: {
//                        Text("Tap me")
//                    })
//                    .buttonStyle(ButtonPrimaryStyle())
//                }
//            }
//            .navigationBarTitle("Messages")
//        }
//        .onAppear {
//            self.viewModel.apply(event: .onAppear)
//        }
    }
    
}

private extension MainUIView {
    
    private var content: some View {
        let oldState = self.viewModel.output.from
        let newState = self.viewModel.output.to
//        guard newState != oldState else {
//            return AnyView(self)
//        }
        let event = self.viewModel.output.event
        switch (newState, event) {
        case (.idle, _):
            return AnyView(Text("Idle"))
        case (.loading, _):
            return AnyView(Text("Loading..."))
        case (.loaded(let data), _):
            return AnyView(Text("Loaded: \(data.joined())"))
        default:
            return AnyView(Text("Something"))
        }
    }
    
}

#if DEBUG
struct MainUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        let datasource = DataSourceConfiguration()
        let configurator = MainConfigurator(datasource: datasource)
        let render = MainSceneRender(configurator: configurator)
        return render.view()
    }
    
}
#endif
