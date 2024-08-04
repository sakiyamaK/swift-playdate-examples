import CPlaydate

private var soundAPI: playdate_sound { playdateAPI.sound.unsafelyUnwrapped.pointee }

public struct FilePlayer: ~Copyable {
    var owned: Bool
    let pointer: OpaquePointer?
    
    public init() {
        self.pointer = soundAPI.fileplayer.pointee.newPlayer()
        self.owned = true
    }
    
    public init(owning pointer: OpaquePointer) {
        self.pointer = pointer
        self.owned = true
    }
    
    public init(borrowing pointer: OpaquePointer) {
        self.pointer = pointer
        self.owned = false
    }
    
    public mutating func forget() {
        self.owned = false
    }
    
    deinit {
        if owned {
            soundAPI.fileplayer.pointee.freePlayer(self.pointer)
        }
    }
}

extension FilePlayer {
    public func loadIntoPlayer(path: StaticString) {
        soundAPI.fileplayer.pointee.loadIntoPlayer(self.pointer, path.utf8Start)
    }
    
    public func play(loop: Int32) {
        soundAPI.fileplayer.pointee.play(self.pointer, loop)
    }
    
    public func pause() {
        soundAPI.fileplayer.pointee.pause(self.pointer)
    }
    
    public var isPlaying: Bool {
        soundAPI.fileplayer.pointee.isPlaying(self.pointer).bool
    }    
}

private extension Int32 {
    var bool: Bool {
        self != 0
    }
}
