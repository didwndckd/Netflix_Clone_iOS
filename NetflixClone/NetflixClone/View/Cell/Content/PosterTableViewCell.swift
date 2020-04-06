//
//  PosterTableViewCell.swift
//  BackgroundImage
//
//  Created by MyMac on 2020/04/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import UIKit
import SnapKit

protocol DismissDelegate: class {
    func dismiss() -> ()
}

class PosterTableViewCell: UITableViewCell {
    static let identifier = "PosterCell"
    
    weak var delegate: DismissDelegate?
    
    private let dismissButton = UIButton()
    private let posterImage = UIImageView()
    private let releaseYear = UILabel()
    private let ageGroup = UIImageView()
    private let runningTime = UILabel()
    private let playButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setUI() {
        [dismissButton, posterImage, releaseYear, ageGroup, runningTime, playButton].forEach {
            contentView.addSubview($0)
        }
        self.backgroundColor = .clear
        
        dismissButton.setImage(UIImage(named: "close"), for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
        
        //MARK: 요청 받아서 이미지 뿌릴 것
        posterImage.image = UIImage(named: "yourName")
        posterImage.contentMode = .scaleToFill
        
        playButton.setTitle("▶︎ 재생", for: .normal)
        playButton.backgroundColor = UIColor.setNetfilxColor(name: .netflixRed)
        playButton.layer.cornerRadius = 3
        
        //MARK: 서버에서 응답 받은 텍스트 및 이미지
        releaseYear.text = "2016"
        releaseYear.textColor = UIColor.setNetfilxColor(name: .netflixLightGray)
        ageGroup.image = UIImage(named: "age-limit")
        ageGroup.contentMode = .scaleAspectFill
        runningTime.text = "1시간 46분"
        runningTime.textColor = UIColor.setNetfilxColor(name: .netflixLightGray)
    }
    
    private func setConstraints() {
        let posterImageWidth = 0.3
        let posterImageHeight = 0.5

        posterImage.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.top.equalTo(contentView.snp.top).offset(CGFloat.dynamicYMargin(margin: 70))
            $0.width.equalTo(contentView).multipliedBy(posterImageWidth)
            $0.height.equalTo(contentView).multipliedBy(posterImageHeight)
        }

        ageGroup.snp.makeConstraints {
            $0.centerX.equalTo(posterImage.snp.centerX)
            $0.top.equalTo(posterImage.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 10))
            $0.width.height.equalTo(CGFloat.dynamicXMargin(margin: 24))
        }

        releaseYear.snp.makeConstraints {
            $0.centerY.equalTo(ageGroup.snp.centerY)
            $0.trailing.equalTo(ageGroup.snp.leading).offset(CGFloat.dynamicXMargin(margin: -10))
        }

        runningTime.snp.makeConstraints {
            $0.centerY.equalTo(ageGroup.snp.centerY)
            $0.leading.equalTo(ageGroup.snp.trailing).offset(CGFloat.dynamicXMargin(margin: 10))
        }

        playButton.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(CGFloat.dynamicXMargin(margin: 10))
            $0.trailing.equalTo(contentView.snp.trailing).offset(CGFloat.dynamicXMargin(margin: -10))
            $0.top.equalTo(ageGroup.snp.bottom).offset(CGFloat.dynamicYMargin(margin: 30))
            $0.height.equalTo(CGFloat.dynamicYMargin(margin: 35))
            $0.bottom.equalTo(contentView.snp.bottom).inset(CGFloat.dynamicYMargin(margin: 5))
        }

        dismissButton.snp.makeConstraints {
            $0.bottom.equalTo(posterImage.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing).offset(CGFloat.dynamicXMargin(margin: -10))
            $0.width.height.equalTo(CGFloat.dynamicXMargin(margin: 30))
        }
    }
    
    @objc private func didTapDismissButton(_ sender: UIButton) {
        delegate?.dismiss()
    }
}
