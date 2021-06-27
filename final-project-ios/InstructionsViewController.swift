import UIKit

class InstructionsViewController: UIViewController, TabRecipePanel {
    var recipe: RecipeInfo?
}

extension InstructionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let instructions = self.recipe?.analyzedInstructions else {
            return 0
        }
        
        if instructions.count == 0 {
            return 0
        }
        
        return instructions[0].steps.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        
        guard let instructions = self.recipe?.analyzedInstructions else {
            return cell
        }
        
        let step = instructions[0].steps[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.textLabel?.text = "\(step.number)- \(step.step)"
        cell.textLabel?.numberOfLines = 12
        cell.textLabel?.sizeToFit()
        
        return cell
    }
}
