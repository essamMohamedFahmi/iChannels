//
//  Refactored by Essam Mohamed Fahmi.
//

import Toast_Swift

class Notifiy
{
    // MARK: Properties
    
    private init(){}
    
    // MARK: Init
    
    static let shared = Notifiy()

    // MARK: Methods
    
    func configNotify()
    {
        ToastManager.shared.style.messageColor = .white
        ToastManager.shared.style.backgroundColor = UIColor.appPrimary.withAlphaComponent(1)
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
        ToastManager.shared.duration = 2
        ToastManager.shared.position = .bottom
    }
    
    func toast(toastMessage: String, completion: (() -> Void)? = nil)
    {
        guard let view = UIApplication.getTopViewController()?.view else { return }
        view.makeToast(toastMessage) { _ in
            completion?()
        }
    }
}
