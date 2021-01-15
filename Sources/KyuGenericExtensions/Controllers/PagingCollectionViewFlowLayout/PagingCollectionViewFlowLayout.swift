//
//  PagingCollectionViewFlowLayout.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/20.
//

import Foundation
import UIKit

public class PagingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        if let collectionView = collectionView {
            itemSize = CGSize(width: collectionView.frame.width - 40, height: collectionView.frame.height)
        }
        
        sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 10
        scrollDirection = .horizontal
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let cv = self.collectionView {

            let cvBounds = cv.bounds
            let halfWidth = cvBounds.size.width * 0.5;
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;

            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {

                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {

                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionView.ElementCategory.cell {
                        continue
                    }

                    if let candAttrs = candidateAttributes {

                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttrs.center.x - proposedContentOffsetCenterX

                        if fabsf(Float(a)) < fabsf(Float(b)) {
                            candidateAttributes = attributes;
                        }

                    }
                    else { // == First time in the loop == //

                        candidateAttributes = attributes;
                        continue;
                    }


                }

                return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y);

            }

        }

        // Fallback
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
}

