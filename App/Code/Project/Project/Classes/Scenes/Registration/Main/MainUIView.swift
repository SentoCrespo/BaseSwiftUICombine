import SwiftUI
import Combine

struct MainUIView: View {
    
    // MARK: - Properties
    @ObservedObject private var viewModel: MainViewModel
//    let render: MainSceneRender?
    /// Disposable bag
    private var bag: Set<AnyCancellable>
    
    // TODO: Inject properties
    init() {
        self.bag = []
        self.viewModel = MainViewModel()
        
        self.handleStateChanges()
    }
    
    func handleStateChanges() {
        self.viewModel.stateMachineSystem
            .system
            .receive(on: RunLoop.main)
            .sink(receiveValue: { stateMachineOutput in
                // Ignore transitions if the state doesn't change
                guard stateMachineOutput.to != stateMachineOutput.from else {
                    return
                }
                switch (stateMachineOutput.to, stateMachineOutput.event) {
                case (.idle, _):
                    print(".Idle")
                case (.loading, _):
                    
                }
            })
            .store(in: &bag)
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
                            self.viewModel.apply(event: .onSelect("Tapped"))
                    }, label: {
                        Text("Tap me")
                    })
                    .buttonStyle(ButtonPrimaryStyle())
                }
            }
            .navigationBarTitle("Messages")
        }
        .onAppear {
            self.viewModel.apply(event: .onAppear)
        }
    }
    
}

private extension MainUIView {
    
//    private var content: some View {
//        switch self.viewModel.stateMachineSystem.state {
//        case .idle:
//            return Color.clear.eraseToAnyView()
//        case .loading:
//            return spinner.eraseToAnyView()
//        case .error(let error):
//            return Text(error.localizedDescription).eraseToAnyView()
//        case .loaded(let movie):
//            return self.movie(movie).eraseToAnyView()
//        }
//    }
    
}

#if DEBUG
struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
#endif
