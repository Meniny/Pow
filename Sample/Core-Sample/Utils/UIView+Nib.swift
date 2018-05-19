//
//  UIView+Nib.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(type(of: self).className, owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        contentView.fillSuperview()
        return contentView
    }
}
