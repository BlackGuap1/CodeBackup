//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Guap1 on 2020/12/27.
//

// viewmodel
import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject {
    
    static let palette: String = "👨🏼‍💻🧓🏻👶🏿👩🏻‍🦰"
    
    @Published private var emojiArt: EmojiArt
    
    /*{
        didSet {
            
            print("lebe json = \(emojiArt.json?.utf8 ?? "nil")")
        }
    }*/
    
    /*
     //@Published
     private var emojiArt: EmojiArt = EmojiArt() {
         willSet {
             objectWillChange.send()
         }
         didSet {
             print("lebe json = \(emojiArt.json?.utf8 ?? "nil")")
         }
     }
    */
    
    private static let untitled = "EmojiArtDocument.Utitled"
    
    // 需要 import Combine
    private var autosaveCancellable: AnyCancellable?
    
    var emojis: [EmojiArt.Emoji] {emojiArt.emojis}
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        // 使用$emojiArt 进行注册 sink包含value和error 因为声明@Published 所以不会error 此处舍去error
        // 因为autosaveCancellable 不能是这个函数的局部变量，函数执行完变量就消失，所以在函数外声明一个私有变量
        autosaveCancellable = $emojiArt.sink { emojiArt in
            UserDefaults.standard.setValue(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
        fetchBackgroundImageDate()
    }
    
    @Published private(set) var backgroundImage: UIImage?
    
    // MARK: -Intent(s)
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat){
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize){
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }

    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat){
        if let index = emojiArt.emojis.firstIndex(matching: emoji){
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    var backgroundURL: URL? {
        get {
            emojiArt.backgroundURL
        }
        set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageDate()
        }
    }
    
    private var fetchImageCancellable: AnyCancellable?
    
    private func fetchBackgroundImageDate()
    {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL
        {
            //let session = URLSession.shared   获取一个URLSession共享的session，可用于简单地通过url从网上下载资源
            //let publisher = session.dataTaskPublisher(for: url)
            //                 .map{data, urlResponse in UIImage(data: data)}
            //                 .receive(on: DispatchQueue.main)
            //                 .replaceError(with: nil)
            // //publisher.assign(to: \EmojiArtDocument.backgroundImage, on: self)
            //fetchImageCancellable = publisher.assign(to: \.backgroundImage, on: sel
            fetchImageCancellable?.cancel()
            fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map{data, urlResponse in UIImage(data: data)}  // 将返回的(data, urlResponse)元组 转化为UIImage类型
                .receive(on: DispatchQueue.main) // 收到新的image后在主线程上进行渲染
                .replaceError(with: nil) // 如果收到error，返回的内容是一个nil的image
                // difference between .assign and .sink is that never error in .assign  until the publisher is terminated
                //每当fetchImageCancellable获取到image，会更新backgroundImage，然后会同步到view上
                //Param to means the key path to the property to be set when the value published
                //Param on means the container of the property
                .assign(to: \.backgroundImage, on: self)
        }
        /*{
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageDate = try? Data(contentsOf: url)
                {
                    DispatchQueue.main.async
                    {
                        if url == self.emojiArt.backgroundURL
                        {
                            self.backgroundImage = UIImage(data: imageDate)
                        }
                    }
                }
            }
        }*/
    }
}

extension EmojiArt.Emoji{
    var fontSize: CGFloat { CGFloat(self.size)}
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y))}
}
