import SwiftUI
import Combine
import Domain

/// UI layer to display the scene
struct HeroDetailsUIView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: HeroDetailsViewModel
    
    // MARK: Life Cycle
    init(viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - UI definition
extension HeroDetailsUIView {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    headerView
                    detailsView
                    Spacer()
                }
                .padding()
                .navigationTitle(viewModel.model.hero.name)
                .navigationBarTitleDisplayMode(.inline)
                .background(Color(.systemBackground))
                .animation(.easeInOut(duration: 0.3), value: viewModel.model.hero)
            }
        }
        .navigationBarBackButtonHidden(false)
        
    }
    
}

// MARK: - Subviews
private extension HeroDetailsUIView {
    
    var headerView: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: viewModel.model.hero.photo)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .transition(.scale)
            } placeholder: {
                ProgressView()
            }
            Text(viewModel.model.hero.realName)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }
    
    var detailsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            detailRow(title: "Height", value: viewModel.model.hero.height)
            detailRow(title: "Power", value: viewModel.model.hero.power)
            detailRow(title: "Abilities", value: viewModel.model.hero.abilities)
            detailRow(title: "Groups", value: viewModel.model.hero.groups)
        }
        .padding(.horizontal)
    }
    
    func detailRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 8)
    }
}

#if DEBUG
struct HeroDetailsUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        self.createPreview()
    }
    
}
#endif
