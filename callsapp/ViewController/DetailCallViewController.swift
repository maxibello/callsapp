//
//  DetailCallViewController.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 31.03.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit

class DetailCallViewController: UIViewController {
    
    var callModel: CallModel?
    private let shadowView = ShadowView(.drop_shadow_0_2_2_4, background: .white, cornerRadius: 16, roundedCorners: [.bottomLeft, .bottomRight])
    private let shadowIconView = ShadowView(.drop_shadow_0_2_2_4, background: .white, cornerRadius: 28, roundedCorners: .allCorners)
    private let iconImageView = UIImageView(image: UIImage(named: "missed"))
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let durationLabel = UILabel()
    private let businessTitleLabel = UILabel()
    private let businessNameLabel = UILabel()
    private let businessNumberLabel = UILabel()
    private let bottomLineView = UIView()
    private let containerView = UIView()
    private let disposeBag = DisposeBag()
    private var viewHeightConstraint: Constraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Missed Call"
        businessTitleLabel.isHidden = true
        
        initialize()
        configUI()
        configConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func initialize() {
        containerView.addSubview(shadowIconView)
        shadowIconView.addSubview(iconImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(durationLabel)
        containerView.addSubview(businessTitleLabel)
        containerView.addSubview(businessNameLabel)
        containerView.addSubview(businessNumberLabel)
        containerView.addSubview(bottomLineView)
        shadowView.addSubview(containerView)
        view.addSubview(shadowView)
    }
    
    private func configUI() {
        guard let callModel = callModel else { return }
        
        containerView.clipsToBounds = true
        bottomLineView.backgroundColor = .lightGray
        bottomLineView.layer.cornerRadius = 2
        
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        durationLabel.font = UIFont.systemFont(ofSize: 13)
        businessTitleLabel.font = UIFont.systemFont(ofSize: 13)
        businessNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        businessNumberLabel.font = UIFont.systemFont(ofSize: 14)
        
        if callModel.client?.name == nil {
            phoneLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        } else {
            phoneLabel.font = UIFont.systemFont(ofSize: 14)
        }
        
        nameLabel.text = callModel.client?.name
        phoneLabel.text = callModel.client?.address
        durationLabel.text = callModel.durationMinSec
        businessTitleLabel.text = "Business number"
        businessNameLabel.text = callModel.businessNumber?.label
        businessNumberLabel.text = callModel.businessNumber?.number
        
    }
    
    private func configConstraints() {
        
        shadowView.snp.makeConstraints { [unowned self] v in
            v.top.equalTo(self.view!.safeAreaLayoutGuide.snp.top)
            v.width.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { v in
            v.edges.equalToSuperview()
        }
        
        shadowIconView.snp.makeConstraints { v in
            v.leading.top.equalToSuperview().offset(16)
            v.size.equalTo(56)
        }
        
        nameLabel.snp.makeConstraints { [unowned shadowIconView] v in
            v.leading.equalTo(shadowIconView.snp.trailing).offset(16)
            v.top.equalToSuperview().offset(29)
            v.trailing.equalToSuperview().offset(-5)
        }
        
        phoneLabel.snp.makeConstraints { [unowned nameLabel] v in
            v.leading.equalTo(nameLabel)
            v.top.equalTo(nameLabel.snp.bottom).offset(7)
        }
        
        durationLabel.snp.makeConstraints { [unowned shadowIconView] v in
            v.top.equalTo(shadowIconView.snp.bottom).offset(8)
            v.centerX.equalTo(shadowIconView)
            self.viewHeightConstraint = v.bottom.equalToSuperview().offset(-30).constraint
        }
        
        iconImageView.snp.makeConstraints { v in
            v.center.equalToSuperview()
        }
        
        businessTitleLabel.snp.makeConstraints {[unowned durationLabel, unowned phoneLabel] v in
            v.top.equalTo(durationLabel.snp.bottom).offset(4)
            v.leading.equalTo(phoneLabel)
        }
        
        businessNameLabel.snp.makeConstraints { [unowned businessTitleLabel] v in
            v.leading.equalTo(businessTitleLabel)
            v.top.equalTo(businessTitleLabel.snp.bottom).offset(8)
        }
        
        businessNumberLabel.snp.makeConstraints { [unowned businessNameLabel] v in
            v.leading.equalTo(businessNameLabel)
            v.top.equalTo(businessNameLabel.snp.bottom).offset(4)
        }
        
        bottomLineView.snp.makeConstraints { v in
            v.height.equalTo(4)
            v.width.equalTo(16)
            v.bottom.equalToSuperview().offset(-13)
            v.centerX.equalToSuperview()
        }
        
    }
    
    private func bind() {
        shadowView.rx.swipeGesture([.down]).when(.recognized)
            .withUnretained(self)
            .bind(onNext: {vc, _ in
                vc.viewHeightConstraint.update(offset: -106)
                UIView.animate(withDuration: 0.5, animations: {
                    vc.view.layoutIfNeeded()
                    vc.businessTitleLabel.isHidden = false
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        vc.businessTitleLabel.isHidden = false
                    })
                })
                
                
            }).disposed(by: disposeBag)
        
        shadowView.rx.swipeGesture([.up]).when(.recognized)
            .withUnretained(self)
            .bind(onNext: {vc, _ in
                vc.viewHeightConstraint.update(offset: -30)
                UIView.animate(withDuration: 0.5, animations: {
                    vc.view.layoutIfNeeded()
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        vc.businessTitleLabel.isHidden = true
                    })
                })
            }).disposed(by: disposeBag)
    }
}
