//
//  UIViewEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/22/20.
//

import UIKit

extension UIView
{
    public func createBlurView(style: UIBlurEffect.Style) -> UIVisualEffectView
    {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        let frame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        return blurEffectView
    }
    
    public func addBlurView(with style: UIBlurEffect.Style)
    {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func setView(hidden: Bool)
    {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: { [unowned self] in
                        self.isHidden = hidden
                        self.layoutIfNeeded()
                       },
                       completion: nil)
    }
    
    func setZeroConstraints(to superView: UIView)
    {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0),
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0)
        ])
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: Handling Gestures

extension UIView
{
    private struct AssociatedObjectKeys
    {
        static var gestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    typealias Action = (() -> Void)
    
    /// store and get back closure
    private var gestureRecognizerAction: Action?
    {
        set
        {
            if let newValue = newValue
            {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        
        get
        {
            let gestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer) as? Action
            return gestureRecognizerActionInstance
        }
    }
    
    /// triggers the closure we stored
    @objc private func handleGestureAction(sender: UITapGestureRecognizer)
    {
        if let action = gestureRecognizerAction
        {
            action()
        }
    }
    
    // MARK: Methods User Can Use
    
    func addTapGestureRecognizer(action: @escaping Action)
    {
        isUserInteractionEnabled = true
        gestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleGestureAction))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addSwipGestureRecognizer(direction: UISwipeGestureRecognizer.Direction,
                                  action: @escaping Action)
    {
        isUserInteractionEnabled = true
        gestureRecognizerAction = action
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGestureAction))
        swipeGesture.direction = direction
        addGestureRecognizer(swipeGesture)
    }
    
    func addPanGestureRecognizer(action: @escaping Action)
    {
        isUserInteractionEnabled = true
        gestureRecognizerAction = action
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGestureAction))
        addGestureRecognizer(panGesture)
    }
}

// MARK: Auto Layout Constraints

extension UIView
{
    func addConstaintsToCenterVertically()
    {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerY,
                                                         relatedBy: .equal,
                                                         toItem: self.superview!,
                                                         attribute: .centerY,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func addConstaintsToCenterHorizontally()
    {
        prepareForConstraints()
        self.superview!.addConstraint(NSLayoutConstraint(item: self,
                                                         attribute: .centerX,
                                                         relatedBy: .equal,
                                                         toItem: self.superview!,
                                                         attribute: .centerX,
                                                         multiplier: 1.0, constant: 0))
    }
    
    func addConstaintsToPinLeadingToSuperview(constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .leading,
                                            multiplier: 1, constant: constant)
        
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addConstaintsToPinTrailingToSuperview(constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .trailing,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addConstaintsToPinTopToSuperview(constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .top,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addConstaintsToPinTopToView(view: UIView,constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .top,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addConstaintsToPinBottomToView(view: UIView, constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .bottom,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addConstaintsToPinBottomToSuperview(constant: CGFloat) -> NSLayoutConstraint
    {
        prepareForConstraints()
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.superview!,
                                            attribute: .bottom,
                                            multiplier: 1, constant: constant)
        self.superview!.addConstraint(constraint)
        return constraint
    }
    
    func addWidthConstraint(constant: CGFloat) -> NSLayoutConstraint
    {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        return widthConstraint
    }
    
    func addHeightConstraint(constant: CGFloat) -> NSLayoutConstraint
    {
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: constant)
        return heightConstraint
    }
    
    private func prepareForConstraints()
    {
        translatesAutoresizingMaskIntoConstraints = false
        if superview == nil
        {
            assert(false, "You need to have a superview before you can add contraints")
        }
    }
    
    
}


extension UIView{
    func rotateRight() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = 0.5
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func rotateLeft() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi / -2)
        rotation.duration = 0
        rotation.isCumulative = true
        rotation.repeatCount = 4
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

extension UIView {
    func cardMaskTopCorners(using cornerRadius: CGFloat = 24) {
        clipsToBounds = true
        
        //    from iOS 11, it's possible to choose which corners are rounded
        if #available(iOS 11.0, *) {
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        layer.cornerRadius = cornerRadius
    }
    
    func cardUnmask() {
        layer.cornerRadius = 0
    }
}

extension UIView
{
    func shakee()
    {
        self.transform = CGAffineTransform(translationX: 7, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func animateScaleForEver()
    {
        let heightScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        heightScaleAnimation.duration = 0.3
        heightScaleAnimation.fromValue = 0.9
        heightScaleAnimation.toValue = 1.1
        heightScaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        heightScaleAnimation.autoreverses = true
        heightScaleAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        let widthScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        widthScaleAnimation.duration = 0.3
        widthScaleAnimation.fromValue = 0.9
        widthScaleAnimation.toValue = 1.1
        widthScaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        widthScaleAnimation.autoreverses = true
        widthScaleAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        self.layer.add(heightScaleAnimation, forKey: nil)
        self.layer.add(widthScaleAnimation, forKey: nil)
    }
}

