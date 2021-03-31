import SnapKit
import UIKit

final class CallViewCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let iconImageView = UIImageView(image: UIImage(named: "missed"))
    private let timeLabel = UILabel()
    private let durationLabel = UILabel()
    let shadowView = ShadowView(.drop_shadow_0_2_2_4, background: .white, cornerRadius: 8, roundedCorners: .allCorners)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        configUI()
        
        shadowView.addSubview(nameLabel)
        shadowView.addSubview(phoneLabel)
        shadowView.addSubview(iconImageView)
        shadowView.addSubview(timeLabel)
        shadowView.addSubview(durationLabel)
        contentView.addSubview(shadowView)
        
        
        configConstraints()
    }
    
    private func configUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        phoneLabel.font = UIFont.systemFont(ofSize: 17)
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        durationLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    private func configConstraints() {
        
        shadowView.snp.makeConstraints {v in
            v.leading.equalToSuperview().offset(16)
            v.trailing.equalToSuperview().offset(-16)
            v.top.equalToSuperview().offset(6)
            v.bottom.equalToSuperview().offset(-6)
        }
        
        iconImageView.snp.makeConstraints { v in
            v.top.equalToSuperview().offset(16)
            v.leading.equalToSuperview().offset(17)
            v.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { [unowned iconImageView] v in
            v.top.equalToSuperview().offset(16)
            v.leading.equalTo(iconImageView.snp.trailing).offset(15)
            v.trailing.equalToSuperview().offset(-5)
        }
        
        phoneLabel.snp.makeConstraints { [unowned nameLabel] v in
            v.top.equalTo(nameLabel.snp.bottom).offset(7)
            v.leading.equalTo(nameLabel)
        }
        
        durationLabel.snp.makeConstraints { [unowned iconImageView] v in
            v.leading.equalTo(iconImageView)
            v.top.equalTo(iconImageView.snp.bottom).offset(8)
            v.bottom.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { v in
            v.top.equalToSuperview().offset(64)
            v.trailing.equalToSuperview().offset(-6)
            v.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setData(_ data: CallModel) {
        nameLabel.text = data.client?.name
        phoneLabel.text = data.client?.address
        timeLabel.text = data.time
        durationLabel.text = data.durationMinSec
        
        if data.client?.name == nil {
            phoneLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
    }
}
