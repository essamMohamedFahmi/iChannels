//
//  PageSheet.swift
//  Wajeez
//
//  Created by Moawiya Thaher on 11/5/20.
//

import SwiftMessages

class SwiftMessagesBottomSegue: SwiftMessagesSegue
{
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController)
    {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .bottomTab)
    }
}

class SwiftMessagesCenterSegue: SwiftMessagesSegue
{
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController)
    {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .centered)
    }
}
