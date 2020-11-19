//
//  ScanDocumentView.swift
//  Tag
//
//  Created by New User on 9/11/20.
//

import SwiftUI
import VisionKit
import Vision


struct ScanDocumentView : UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var recognizedText: [String]
    @Binding var scanSuccess : Bool
        
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, scanSuccess: $scanSuccess, parent: self)
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        //no move
    }
    
}

// Needed to bridge the delegate methods from the ViewController
class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    
    var recognizedText: Binding<[String]>
    var scanSuccess: Binding<Bool>
    var parent: ScanDocumentView
    
    init(recognizedText: Binding<[String]>, scanSuccess: Binding<Bool>, parent: ScanDocumentView) {
        self.recognizedText = recognizedText
        self.scanSuccess = scanSuccess
        self.parent = parent
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // do the processing of the scan
        let extractedImages = extractImages(from: scan)
        let processedText = recognizeText(from: extractedImages)
        recognizedText.wrappedValue = processedText
        scanSuccess.wrappedValue = true
        
        //MARK: Exit the view here
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    // Extract image from the process we scanned
    fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
        var extractedImages = [CGImage]()
        for index in 0..<scan.pageCount {
            // we need to fix the orientation of the picture
            // however,it seems that the orientation of the picture will be disabled when locked orientation
            let extractedImage = fixOrientation(img: scan.imageOfPage(at: index))
            guard let cgImage = extractedImage.cgImage else { continue }
            
            extractedImages.append(cgImage)
        }
        return extractedImages
    }
    
    fileprivate func recognizeText(from images: [CGImage]) -> [String] {
        var entireRecognizedText : [String] = []
        let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard error == nil else { return }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                
                // we put the string recognized together
                entireRecognizedText.append(candidate.string)
                
            }
        }
        // we want a higher quality in recognition
        recognizeTextRequest.recognitionLevel = .accurate
        recognizeTextRequest.recognitionLanguages = ["en-US", "en-GB"]
        recognizeTextRequest.usesLanguageCorrection = true
        
        for image in images {
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            
            try? requestHandler.perform([recognizeTextRequest])
        }
        
        return entireRecognizedText
    }
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }

        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }
}
