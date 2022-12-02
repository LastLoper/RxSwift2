//
//  AlertActionConvertible.swift
//  BlogSearch
//
//  Created by WalterCho on 2022/12/01.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
