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
                searchBar
                listContent
            }
            .navigationBarTitle("Heroes", displayMode: .large)
        }
    }
    
}

private extension HeroListUIView {
    
    private var searchBar: some View {
        TextField("Search heroes...", text: $viewModel.model.searchText)
            .padding()
            .autocorrectionDisabled(true)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding([.horizontal, .top])
    }
    
    var listContent: some View {
        List(viewModel.model.heroesFiltered, id: \.name) { hero in
            HeroRowView(hero: hero)
                .onTapGesture {
                    viewModel.onSelect(hero: hero)
                }
                .listStyle(PlainListStyle())
        }
    }
    
}

private struct HeroRowView: View {
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

#if DEBUG
struct HeroListUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }
    
}
#endif
