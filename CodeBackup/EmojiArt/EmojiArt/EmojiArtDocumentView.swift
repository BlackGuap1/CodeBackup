//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Guap1 on 2020/12/27.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    @State private var chosenPalette: String = ""
    
    var body: some View {
        VStack {
            HStack {
                PaletteChooser(document: document, chosenPalette: $chosenPalette)
            // map return an array of String
            //ScrollView(.horizontal) 滚动条，参数表明滚动方向
                ScrollView(.horizontal) {
                    HStack {
                            // \.self -> String($0).self    \.表示路径
                        ForEach(chosenPalette.map { String($0) }, id: \.self) { emoji in
                                Text(emoji)
                                    .font(Font.system(size: defaultEmojiSize))
                                    .onDrag { NSItemProvider(object: emoji as NSString)}
                            }
                        }
                }
                    .padding(.horizontal)
                .onAppear{self.chosenPalette = self.document.defaultPalette}
            }
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.zoomScale)
                            .offset(self.panOffset)
                    )
                        .gesture(self.doubleTapZoom(in: geometry.size))
                    if !isLoading {
                        ForEach(self.document.emojis) { emoji in
                            Text(emoji.text)
                                .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                                .position(self.position(for: emoji, in: geometry.size))
                        }
                    } else {
                        Image(systemName: "hourglass").imageScale(.large).spinning()
                    }
                }
                    .clipped()
                    .gesture(self.panGesture())
                    .gesture(self.zoomGesture())
                    .edgesIgnoringSafeArea([.horizontal, .bottom])
                    .onReceive(self.document.$backgroundImage) { image in
                        self.zoomToFit(image, in: geometry.size)
                    }
                    .onDrop(of: ["public.image", "public.text"], isTargeted: nil){ providers, location in
                        var location = geometry.convert(location, from: .global)
                        location = CGPoint(x: location.x - geometry.size.width/2, y:location.y - geometry.size.height/2)
                        location = CGPoint(x: location.x - self.panOffset.width, y:location.y - self.panOffset.height)
                        location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                        return self.drop(providers: providers, at: location)
                    }
            }
        }
    }
    
    var isLoading: Bool {
        document.backgroundURL != nil && document.backgroundImage == nil
    }
    
    //this var updated when the gesture end
    @State private var steadyStateZoomScale: CGFloat = 1.0
    
    //when gesture happen, this var record the state
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                self.steadyStateZoomScale *= finalGestureScale
            }
    }
    
    //单指移动的gesture
    @State private var steadyStatePanOffset: CGPoint = .zero
    @GestureState private var gesturePanOffset: CGPoint = .zero

    private var panOffset: CGSize{
        //这样直接加一搬做不了的，所以增加了extension
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }

    private func panGesture() -> some Gesture{
        DragGesture()
            .updating($gesturePanOffset){ latestDragGestureValue, gesturePanOffset, transient in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
            }
            .onEnded{ finalDragGestureValue in
                self.steadyStatePanOffset = self.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
            }
    }
    
    //双击放大/缩小的gesture,
    private func doubleTapZoom(in size: CGSize) -> some Gesture{
        TapGesture(count: 2)
            .onEnded {
                //withAnimation(.linear(duration: 4)) 通过慢动画来找问题
                withAnimation{
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStatePanOffset = .zero
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize * zoomScale)
    }
    
    private func position(for emoji: EmojiArt.Emoji , in size: CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x * self.zoomScale, y: location.y * self.zoomScale)
        location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
        location = CGPoint(x: location.x + self.panOffset.width, y:location.y + self.panOffset.height)
        return location
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool
    {
        var found = providers.loadObjects(ofType: URL.self) { url in
            //print("lebe dropped /(url)")
            self.document.backgroundURL = url
        }
        if !found
        {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    
    private let defaultEmojiSize: CGFloat = 40
}

/*extension String: Identifiable {
    public var id: String { return self}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
