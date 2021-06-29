protocol TabRecipePanel {
    var recipe: RecipeInfo? { get set }
    var delegate: RecipeNotedListDelegate?{ get set }
}
