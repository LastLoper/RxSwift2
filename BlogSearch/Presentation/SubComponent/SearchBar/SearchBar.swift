//
//  SearchBar.swift
//  BlogSearch
//
//  Created by WalterCho on 2022/12/01.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchBtn = UIButton()
    
    //SearchBar 버튼 앱 이벤트
    let searchBtnTapped = PublishRelay<Void>()
    
    //SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        //키보드의 검색 버튼을 눌렀을 때
        //서치바의 검색 버튼을 눌렀을 때
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchBtn.rx.tap.asObservable()
            )
            .bind(to: searchBtnTapped)
            .disposed(by: disposeBag)
        
        searchBtnTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        self.shouldLoadResult = searchBtnTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    private func attribute() {
        searchBtn.setTitle("검색", for: .normal)
        searchBtn.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchBtn)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchBtn.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
