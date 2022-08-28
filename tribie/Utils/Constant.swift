//
//  constant.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

class AppConstant {
    static let KEYCHAIN_TOKEN = "token"
    
    /* For network related*/
    static let APPLICATION_JSON  = "application/json"
    static let AUTHORIZATION = "Authorization"
    static let CONTENT_TYPE = "Content-Type"
    static let CLIENT_KEY = "Client-Key"
    static let ACCEPT = "Accept"
    static let MULTIPART_FORM_DATA = "multipart/form-data"
    static let FORM_DATA = "form-data"
    static let CONTENT_DISPOSITION = "Content-Disposition"
    
    /* For App Related*/
    static let MIME_IMAGE_JPEG = "image/jpeg"
    static let MIME_PDF = "application/pdf"
    static let FILE_TYPE_JPG = ".jpg"
    static let KEY_FILE = "file"
    static let MIME_ALL = "*/*"
    static let DOC_TYPE_PDF = "pdf"
    static let FILE_NAME_PDF = "Documents.pdf"
    static let FILE_NAME_JPEG = "defaultImage.jpg"
    
    static let USER_STATUS_REJECTED = "Rejected"
    static let USER_STATUS_APPROVED = "Approved"
    static let USER_DOCUMENT_NOT_COMPLETED = "Data Belum Lengkap"
    static let USER_NOT_REGISTERED = "Belum Daftar"
    static let USER_DATA_COMPLETED = "data is completed"
    static let USER_STATUS_VERIFIYING = "Sedang diverifikasi"
    static let USER_STATUS_UNVERIFIED = "Unverified"
    
    /* Date Format */
    static let DEFAULT_EMPTY_DATE = "1997-05-02"
    static let DEFAULT_DATE_FORMAT = "yyyy-MM-dd"
}
