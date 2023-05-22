import Foundation

class OnceCall {
    
    var already: Bool = false
    
    func run(block: () -> Void) {
        guard !already else { return }
        
        block()
        already = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.already = false
        }
    }
}
