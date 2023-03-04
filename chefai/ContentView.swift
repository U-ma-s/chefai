
import OpenAISwift
import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()

    
    
    var body: some View {
        
        VStack{
            List {
                ForEach(models, id: \.self) { string in
                    Text(string)
                }
                
            }
            HStack {
                TextField("Type here...", text: $text)
                Button("Send") {
                    send()
                    text = ""
                }
            }
            .onAppear {
                viewModel.setup()
            }
        }
        .padding()
   }

    
    func send() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        models.append("Me: \(text)")
        viewModel.send(text: text) { respons in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: "+respons)
                
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
