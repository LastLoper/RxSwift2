//
//  FilterView.swift
//  BlogSearch
//
//  Created by WalterCho on 2022/12/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    let sortBtn = UIButton()
    let bottomBorder = UIView()
    
    //FilterView 외부에서 관찰
    let sortBtnTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        sortBtn.rx.tap
            .bind(to: sortBtnTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        sortBtn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    private func layout() {
        [sortBtn, bottomBorder].forEach {
            addSubview($0)
        }
        
        sortBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(sortBtn.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
