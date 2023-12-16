//
//  CBBUtton.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import RxSwift

class CBButton: UIView {
    enum Status {
        case enabled
        case disabled
        case loading
        case borderEnabled
        case borderDisabled
        case borderLoading
    }

    @IBOutlet var view: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()

    var text: String = "" {
        didSet {
            if status != .loading {
                button.setTitle(text, for: .normal)
            }
        }
    }

    var status: Status = .enabled {
        didSet {
            isUserInteractionEnabled = true
            button.backgroundColor = .cbThemeColor
            activityIndicatorView.stopAnimating()
            button.setTitle(text, for: .normal)
            switch status {
            case .disabled:
                isUserInteractionEnabled = false
                button.backgroundColor = .inActiveButtonColor
            case .loading:
                setLoading()
            case .borderEnabled:
                setBorder(true)
            case .borderDisabled:
                setBorder(false)
            case .enabled:
                setEnabled()
            case .borderLoading:
                setBorderLoading(true)
            }
        }
    }

    var setBackgroundColor: UIColor {
        get {
            return button.backgroundColor ?? .cbThemeColor
        }
        set {
            button.backgroundColor = newValue
            view.backgroundColor = newValue
        }
    }

    var setTextColor: UIColor {
        get {
            return button.currentTitleColor
        }
        set {
            button.setTitleColor(newValue, for: .normal)
        }
    }

    var setFont: UIFont {
        get {
            return button.titleLabel?.font ?? UIFont()
        }
        set {
            button.titleLabel?.font = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    fileprivate func configureViews() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        button.layer.cornerRadius = frame.size.height / 2
        view.layer.cornerRadius = frame.size.height / 2
        button.backgroundColor = .cbThemeColor
        button.clipsToBounds = true
        view.layer.masksToBounds = false
    }

    func configureCornerRadius(_ radius: CGFloat = 16) {
        button.layer.cornerRadius = radius
        view.layer.cornerRadius = radius
        layer.cornerRadius = radius
    }

    private func loadViewFromNib() {
        view = UINib(nibName: ViewIds.cbButtonIdentifier.rawValue, bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView

        view.frame = bounds
        configureViews()
        addSubview(view)
    }

    private func setEnabled() {
        isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        button.setTitle(text, for: .normal)
    }

    private func setDisabled() {
        isUserInteractionEnabled = false
        button.backgroundColor = .inActiveButtonColor
    }

    private func setLoading() {
        button.setTitle("", for: .normal)
        isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
    }

    private func setBorderLoading(_ enabled: Bool) {
        setLoading()
        setBorder(enabled)
    }

    private func setBorder(_ enabled: Bool) {
        isUserInteractionEnabled = enabled
        setBackgroundColor = .white
        activityIndicatorView.color = .cbThemeColor
        layer.borderColor = enabled ? UIColor.cbThemeColor.cgColor : UIColor.inActiveButtonColor.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = frame.height / 2
        setTextColor = enabled ? .cbThemeColor : .inActiveButtonColor
    }

    func removeTarget() {
        button.removeTarget(nil, action: nil, for: .allEvents)
    }

    func removeShadow() {
        view.layer.shadowColor = UIColor.clear.cgColor
    }
}
