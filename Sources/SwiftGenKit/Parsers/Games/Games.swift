//
// SwiftGenKit
// Copyright © 2019 SwiftGen
// MIT Licence
//
import Foundation
import PathKit

public enum Game {
  public final class Parser: SwiftGenKit.Parser {
    
    var entries: Set<String> = []
    public var warningHandler: Parser.MessageHandler?
    
    public init(options: [String: Any] = [:], warningHandler: Parser.MessageHandler? = nil) {
      self.warningHandler = warningHandler
    }
    
    public static let defaultFilter = "[^/]\\.(?i:zip)$"
    
    public func parse(path: Path, relativeTo parent: Path) throws {
      let name = path.lastComponentWithoutExtension
      
      addGame(name)
    }
    
    private func addGame(_ game: String) {
        
      entries.insert(game)
    }
    
    public func stencilContext() -> [String : Any] {
      let games = Array(entries).map({ (rawGame) -> (String, String, String) in
          let arr = rawGame.split(separator: "_").map(String.init)
          let identifier = arr.dropFirst().joined(separator: "_")
          return (
              provider: arr.first!,
              gameIdentifier: identifier,
              propertName: identifier.replacingOccurrences(of: "-", with: "_").replacingOccurrences(of: ".", with: "_")
          )
      })
      
      let gamesDictionary = Dictionary(grouping: games, by: { (provider: String, _, _) in
          return provider
      }).map { (key, values) in
          ["provider": key, "values": values.map { ["gameIdentifier": $0.1, "propertyName": $0.2] } ]
      }
      
      return [
        "games": gamesDictionary
      ]
    }
  }
}
