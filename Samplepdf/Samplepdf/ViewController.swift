//
//  ViewController.swift
//  Samplepdf
//
//  Created by MOUNICA CHOWDARY  YELISETTI on 2018-11-16.
//  Copyright © 2018 MOUNICA CHOWDARY  YELISETTI. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView!
    var myPdfDocument:PDFDocument?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromURL()
        // loadFromMainBundle()
    }
    private func loadFromMainBundle() {
        if let path = Bundle.main.path(forResource: "geographic", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
                myPdfDocument = pdfDocument
            }
        }
    }
    
    private func loadFromURL() {
        //guard let url = URL(string:"http://www.africau.edu/images/default/sample.pdf") else { return }
        guard let url = URL(string:"https://www.tdcanadatrust.com/document/PDF/accounts/direct-deposit-en.pdf") else { return }
        
        if let pdfDocument = PDFDocument(url: url) {
            pdfView.autoScales = true
            pdfView.displayMode = .singlePageContinuous
            pdfView.displayDirection = .vertical
            pdfView.document = pdfDocument
            myPdfDocument = pdfDocument
        }
    }
    @IBAction func sharePDF(_ sender: Any) {
        guard let data = myPdfDocument?.dataRepresentation() else { return }
        let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
}

