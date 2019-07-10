//
//  Request.swift
//  iOSTemplate
//
//  Created by Hanh Pham N on 5/8/19.
//  Copyright © 2019 hpn. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension ApiManager {

    // MARK: - API Request
    /// Send a request to server
    ///
    /// - parameter target:  Target info of request Include: url, method, headers, params.
    /// - parameter completion:  The closure called when upload complete or failed
    ///
    /// - returns: The created `Request`.
    @discardableResult
    func request(target: Target, completion: ApiCompletion?) -> Request? {
        guard api.networkAvailable else {
            completion?(.failure(NSError.serviceError))
            return nil
        }

        let encoding: ParameterEncoding
        if target.method == .post {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }

        let request = Alamofire.request(target.path,
                                        method: target.method,
                                        parameters: target.params,
                                        encoding: encoding,
                                        headers: target.headers)
        request.responseObject { (response: DataResponse<ResponseObject>) in
            self.handlerResult(response, completion: { completion?($0) })
        }
        return request
    }

    // MARK: - Upload
    /// Upload datas to server.
    ///
    /// If you want to cancel upload request, You can call `uploadRequest` variable and use `cancel()` function
    ///
    /// - parameter target:  Target info of request Include: url, method, headers, params.
    /// - parameter datas:   Datas need upload.
    /// - parameter progressHandler:    The closure called when the progress change
    /// - parameter completion:  The closure called when upload complete or failed
    func upload(target: Target, datas: [UploadData],
                progressHandler: @escaping UploadRequest.ProgressHandler,
                completion: @escaping ApiCompletion) {
        Alamofire.upload(multipartFormData: { formData in
            datas.forEach({ uploadData in
                formData.append(uploadData.data,
                                withName: uploadData.name,
                                fileName: uploadData.fileName,
                                mimeType: uploadData.mimeType)
            })

            target.params?.forEach({ (key, value) in
                if let data = (value as? String)?.data(using: String.Encoding.utf8) {
                    formData.append(data, withName: key)
                }
            })
        }, to: target.path,
           method: target.method,
           headers: target.headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let request, _, _):
                self.uploadRequest = request
                request.uploadProgress(closure: { progressHandler($0) })
                request.responseObject { (response: DataResponse<ResponseObject>) in
                    self.handlerResult(response, completion: { completion($0) })
                    self.uploadRequest = nil
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    // MARK: - Cancel upload
    /// Cancel current uploading
    func cancelUpload() {
        uploadRequest?.cancel()
        uploadRequest = nil
    }
}
