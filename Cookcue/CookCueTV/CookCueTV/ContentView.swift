
import SwiftUI
import Combine

// MARK: - Recipe Model

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let time: String
    let imageURL: String
    let description: String
    let ingredients: [String]
    let steps: [String]
    let timerSeconds: Int
}

// MARK: - Sample Recipes

private let sampleRecipes: [Recipe] = [
    Recipe(
        name: "Creamy Pasta",
        category: "QUICK & EASY",
        time: "20 min",
        imageURL: "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1000&q=80",
        description: "A comforting pasta dish for busy evenings.",
        ingredients: [
            "200 g pasta",
            "1 cup cooking cream",
            "2 garlic cloves",
            "2 tbsp grated cheese",
            "Salt and pepper"
        ],
        steps: [
            "Bring a pot of salted water to a boil.",
            "Cook the pasta according to the packet instructions.",
            "Saute the garlic in a pan until fragrant.",
            "Add the cream and stir gently.",
            "Mix in the cooked pasta and grated cheese.",
            "Season to taste and serve warm."
        ],
        timerSeconds: 300
    ),

    Recipe(
        name: "Fresh Garden Salad",
        category: "HEALTHY",
        time: "10 min",
        imageURL: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=1000&q=80",
        description: "A colourful, refreshing salad made with fresh ingredients.",
        ingredients: [
            "2 cups lettuce",
            "1 cucumber",
            "2 tomatoes",
            "1 tbsp olive oil",
            "Lemon juice and salt"
        ],
        steps: [
            "Wash and dry all the vegetables.",
            "Slice the cucumber and tomatoes.",
            "Tear the lettuce into bite-sized pieces.",
            "Combine the vegetables in a large bowl.",
            "Add olive oil, lemon juice and salt.",
            "Toss gently and serve fresh."
        ],
        timerSeconds: 120
    ),

    Recipe(
        name: "Pancakes",
        category: "BREAKFAST",
        time: "15 min",
        imageURL: "https://images.unsplash.com/photo-1528207776546-365bb710ee93?auto=format&fit=crop&w=1000&q=80",
        description: "Fluffy pancakes for a delicious breakfast.",
        ingredients: [
            "1 cup flour",
            "1 egg",
            "3/4 cup milk",
            "1 tsp baking powder",
            "1 tbsp sugar"
        ],
        steps: [
            "Mix the flour, sugar and baking powder.",
            "Whisk the egg and milk in another bowl.",
            "Combine the wet and dry ingredients.",
            "Heat a lightly greased pan.",
            "Pour in some batter and cook until bubbles appear.",
            "Flip, cook the other side and serve."
        ],
        timerSeconds: 120
    )
]

// MARK: - Home Screen

struct ContentView: View {

    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.075, green: 0.09, blue: 0.11)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {

                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("COOKCUE")
                                    .font(.headline)
                                    .tracking(5)
                                    .foregroundStyle(.orange)

                                Text("Let's make something delicious.")
                                    .font(.system(size: 38, weight: .bold))
                                    .foregroundStyle(.white)
                            }

                            Spacer()

                            Image(systemName: "frying.pan")
                                .font(.system(size: 45))
                                .foregroundStyle(.orange)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("WHAT'S COOKING TODAY?")
                                .font(.title2)
                                .foregroundStyle(.white)

                            Text("Simple recipes. One step at a time.")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.7))
                        }

                        Text("Explore Recipes")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(sampleRecipes) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipe: recipe)
                                } label: {
                                    RecipeCard(recipe: recipe)
                                }
                                .buttonStyle(.card)
                            }
                        }

                        Label {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Ready to start cooking?")
                                    .font(.title2.bold())

                                Text("Choose a recipe and follow each step.")
                                    .font(.body)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                        } icon: {
                            Image(systemName: "timer")
                                .font(.system(size: 35))
                                .foregroundStyle(.orange)
                        }
                        .foregroundStyle(.white)
                        .padding(22)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    .padding(35)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Recipe Card

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            AsyncImage(url: URL(string: recipe.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Image(systemName: "fork.knife")
                        .font(.system(size: 45))
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white.opacity(0.08))

                default:
                    ProgressView()
                        .tint(.orange)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white.opacity(0.08))
                }
            }
            .frame(height: 155)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(recipe.category)
                .font(.caption.bold())
                .tracking(1)
                .foregroundStyle(.orange)

            Text(recipe.name)
                .font(.title2.bold())
                .foregroundStyle(.white)
                .lineLimit(1)

            Label(recipe.time, systemImage: "clock")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.09))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Recipe Details
// Start Cooking is positioned BEFORE the ingredients.

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ZStack {
            Color(red: 0.075, green: 0.09, blue: 0.11)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {

                    AsyncImage(url: URL(string: recipe.imageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            Rectangle()
                                .fill(.white.opacity(0.08))
                                .overlay {
                                    Image(systemName: "fork.knife")
                                        .font(.system(size: 50))
                                        .foregroundStyle(.orange)
                                }
                        }
                    }
                    .frame(height: 220)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text(recipe.category)
                        .font(.headline)
                        .foregroundStyle(.orange)

                    Text(recipe.name)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    Text(recipe.description)
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.75))

                    Label(recipe.time, systemImage: "clock")
                        .font(.headline)
                        .foregroundStyle(.orange)

                    // START COOKING BUTTON

                    NavigationLink {
                        CookingView(recipe: recipe)
                    } label: {
                        Label("Start Cooking", systemImage: "play.fill")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity)
                            .padding(18)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .padding(.vertical, 5)

                    // INGREDIENTS

                    Text("Ingredients")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Label(ingredient, systemImage: "circle")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }
                .padding(30)
            }
        }
        .navigationTitle(recipe.name)
    }
}

// MARK: - Cooking Mode

struct CookingView: View {
    let recipe: Recipe

    @State private var currentStep = 0
    @State private var remainingSeconds = 0
    @State private var isTimerRunning = false

    private let ticker = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.075, green: 0.09, blue: 0.11)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Text(recipe.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.orange)

                Text("STEP \(currentStep + 1) OF \(recipe.steps.count)")
                    .font(.headline)
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.7))

                ProgressView(
                    value: Double(currentStep + 1),
                    total: Double(recipe.steps.count)
                )
                .tint(.orange)

                Text(recipe.steps[currentStep])
                    .font(.system(size: 34, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .frame(maxWidth: 900)
                    .padding(20)

                HStack(spacing: 24) {
                    Button("Previous") {
                        currentStep = max(0, currentStep - 1)
                    }
                    .disabled(currentStep == 0)

                    Button(
                        currentStep == recipe.steps.count - 1
                        ? "Finish"
                        : "Next Step"
                    ) {
                        if currentStep < recipe.steps.count - 1 {
                            currentStep += 1
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .disabled(currentStep == recipe.steps.count - 1)
                }

                Divider()

                Text("COOKING TIMER")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.7))

                Text(
                    String(
                        format: "%02d:%02d",
                        remainingSeconds / 60,
                        remainingSeconds % 60
                    )
                )
                .font(.system(size: 54, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.orange)

                HStack(spacing: 20) {
                    Button(
                        isTimerRunning ? "Pause" : "Start Timer"
                    ) {
                        isTimerRunning.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .disabled(remainingSeconds == 0)

                    Button("Reset Timer") {
                        isTimerRunning = false
                        remainingSeconds = recipe.timerSeconds
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(40)
        }
        .onAppear {
            remainingSeconds = recipe.timerSeconds
        }
        .onReceive(ticker) { _ in
            if isTimerRunning && remainingSeconds > 0 {
                remainingSeconds -= 1
            }

            if remainingSeconds == 0 {
                isTimerRunning = false
            }
        }
        .navigationTitle("Cooking Mode")
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}


import SwiftUI

struct KitchenBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("KitchenBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .clipped()

                Color.black.opacity(0.60)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

