import AVFoundation

final class AudioPlayerHelper {
    
    static let shared = AudioPlayerHelper()
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playSound(named fileName: String, withExtension fileExtension: String = "mp3") {
        if let player = audioPlayer, player.isPlaying {
            player.stop()
        }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("mp3 no found: \(fileName).\(fileExtension)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
