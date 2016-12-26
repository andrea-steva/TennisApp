import SwiftyBeaver

/// SwiftyBeaver logger (https://github.com/SwiftyBeaver/SwiftyBeaver)
public let Log = SwiftyBeaver.self

final public class Logger: NSObject {
    
    init(level: SwiftyBeaver.Level = .verbose) {
        super.init()
        
        //Add the logger
        let xCodeConsole = ConsoleDestination()
        xCodeConsole.asynchronously = false
        xCodeConsole.minLevel = level
        
        //Change default color
        xCodeConsole.levelColor.info = "fg28,87,215;"
        xCodeConsole.levelColor.warning = "fg253,147,50;"
        xCodeConsole.levelString.verbose = "🔶 VERBOSE"
        xCodeConsole.levelString.debug = "⚪️ DEBUG"
        xCodeConsole.levelString.info = "🔵 INFO"
        xCodeConsole.levelString.warning = "⚠️ WARNING"
        xCodeConsole.levelString.error = "🔴 ERROR"
        xCodeConsole.format = "$DHH:mm:ss$d $L $M"
        
        Log.addDestination(xCodeConsole)
    }
}
