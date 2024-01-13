import SwiftUI
import Combine

/// UI layer to display the scene
struct MainUIView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: MainViewModel
    
    // MARK: Life Cycle
    init(viewModel: MainViewModel) {
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
        case (.loaded, .onLoadingSuccess(let data)):
            return AnyView(Text("Loaded: \(data)"))
        default:
            return AnyView(Text("Something"))
        }
    }
    
}

#if DEBUG
struct MainUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }
    
}
#endif
