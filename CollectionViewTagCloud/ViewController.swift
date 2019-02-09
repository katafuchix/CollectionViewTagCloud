//
//  ViewController.swift
//  CollectionViewTagCloud
//
//  Created by cano on 2019/02/07.
//  Copyright © 2019 deskplate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let items = ["スイーツ", "パン", "スイーツ", "カフェ", "金沢", "駅前寿司", "祇園", "嵐山", "天満", "七本槍", "鶴橋", "灘", "篠山", "長浜ラーメン", "彦根", "奈良町", "ひがし茶屋街", "尾道", "ランチ", "おばんざい", "寿司", "焼肉", "カレー", "パスタ", "お好み焼き", "越前そば", "チョコレート", "手みやげ", "和雑貨", "文具", "本屋", "酒蔵", "パワースポット", "城下町", "庭園", "アート", "フォトジェニック", "絶景"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        self.collectionView.collectionViewLayout = layout
    }


}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // スタンプが押された時の処理を書く
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {

    // セクションヘッダのサイズ
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    // セルのサイズ
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.items[indexPath.row]
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 30, height: 40)
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.label.text = self.items[indexPath.row]
        cell.layer.masksToBounds   = true
        cell.layer.cornerRadius    = 14
        return cell
    }
}

// セルを左詰にするFlowLayout
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
