import Foundation
import AVFoundation

// force the function to have a name callable by the c code
@_silgen_name("swiftRequestAccess")
public func swiftRequestAccess(number: Int) -> Int {
    
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    var result = 35
    
    if status == .authorized {
        print("Access is set to authorized")
        return 11
    }
    
    if status == .denied {
        print("Access is set to denied")
        return 22
    }
    
    print("Requesting Access")
    
    let semaphore = DispatchSemaphore(value: 0 )
    let queue = DispatchQueue(label: "com.gcd.Queue", attributes: .concurrent)
    
    queue.async {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            if(granted) {
                print("Acces was GRANTED by user")
                result=33
                semaphore.signal();
            } else {
                print("Acces was DENIED by user")
                result=34
                semaphore.signal();
            }
        }
    }
    
    semaphore.wait()
    
    return result // Should not occur
    
}
