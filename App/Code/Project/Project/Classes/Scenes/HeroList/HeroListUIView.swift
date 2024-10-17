import SwiftUI
import Combine
import Domain

/// UI layer to display the scene
struct HeroListUIView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: HeroListViewModel
    
    // MARK: Life Cycle
    init(viewModel: HeroListViewModel) {
        self.viewModel = viewModel
    }

}

// MARK: - UI definition
extension HeroListUIView {
    var body: some View {
        NavigationView {
            VStack {
                listContent
            }
            .navigationBarTitle("Heroes", displayMode: .large)
            .searchable(
                text: $viewModel.model.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
        }
    }
    
}

private extension HeroListUIView {
    
    var listContent: some View {
        List(viewModel.model.heroesFiltered, id: \.name) { hero in
            HeroRowView(hero: hero)
                .onTapGesture {
                    viewModel.onSelect(hero: hero)
                }
                .listStyle(PlainListStyle())
        }
        .animation(.easeInOut, value: viewModel.model.heroesFiltered)
        .transition(.opacity)
    }
    
    struct HeroRowView: View {
        let hero: Hero
        
        var body: some View {
            HStack {
                AsyncImage(url: URL(string: hero.photo)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text(hero.name)
                        .font(.headline)
                    Text(hero.realName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
    }
    
}

#if DEBUG
struct HeroListUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }
    
}
#endif
