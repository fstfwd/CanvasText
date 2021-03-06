//
//  NumberView.swift
//  CanvasText
//
//  Created by Sam Soffes on 3/14/16.
//  Copyright © 2016 Canvas Labs, Inc. All rights reserved.
//

import UIKit
import CanvasNative
import X

final class NumberView: ViewType, Annotation {

	// MARK: - Private

	var block: Annotatable

	var theme: Theme {
		didSet {
			backgroundColor = theme.backgroundColor
			tintColor = theme.tintColor
			setNeedsDisplay()
		}
	}

	var horizontalSizeClass: UserInterfaceSizeClass = .Unspecified


	// MARK: - Initializers

	init?(block: Annotatable, theme: Theme) {
		guard let orderedListItem = block as? OrderedListItem else { return nil }
		self.block = orderedListItem
		self.theme = theme

		super.init(frame: .zero)

		userInteractionEnabled = false
		contentMode = .Redraw
		backgroundColor = theme.backgroundColor
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - UIView

	override func drawRect(rect: CGRect) {
		guard let block = block as? OrderedListItem else { return }

		let string: NSString = "\(block.number)."
		let attributes = [
			NSForegroundColorAttributeName: theme.orderedListItemNumberColor,
			NSFontAttributeName: TextStyle.body.font().fontWithMonospacedNumbers
		]

		let size = string.sizeWithAttributes(attributes)

		// TODO: It would be better if we could calculate this from the font
		let rect = CGRect(
			x: bounds.width - size.width - 4,
			y: ((bounds.height - size.height) / 2) - 1,
			width: size.width,
			height: size.height
		).integral

		string.drawInRect(rect, withAttributes: attributes)
	}
}
