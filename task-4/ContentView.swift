import SwiftUI

#Preview {
    ContentView()
}

struct CustomButtonStyle: ButtonStyle {

    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat = 0.86) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .opacity(configuration.isPressed ? 1 : 0)
            configuration.label
            
        }
        .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
        .animation(.easeIn(duration: 0.22),
                   value: configuration.isPressed)
        .transaction { $0.disablesAnimations = false }
    }
}

struct ContentView: View {
    
    @State var isStarted = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.bouncy(duration: 0.3, extraBounce: 0.2)) {
                    isStarted = true
                } completion: {
                    isStarted = false
                }
            }) {
                HStack(spacing: 0) {
                    ZStack {
                        Image(systemName: "arrowtriangle.right.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaleEffect(isStarted ? 1 : 0, anchor: .leading)
                            .opacity(isStarted ? 1 : 0)
                        
                        Image(systemName: "arrowtriangle.right.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(x: isStarted ? 50 : 0)
                    }

                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaleEffect(isStarted ? 0 : 1, anchor: .trailing)
                        .opacity(isStarted ? 0 : 1)
                }
            }
            .buttonStyle(CustomButtonStyle())
            .frame(maxWidth: 150)
        }
    }
}
