//
//  MyLiveViewController.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/7.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

class MyLiveViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var onlineCountLabel: UILabel!
    @IBOutlet weak var connectionLabel: UILabel!
    
    @IBOutlet weak var liveTitleTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    private lazy var liveSession: LFLiveSession = {
        let audioConf = LFLiveAudioConfiguration.defaultConfiguration()
        let videoConf = LFLiveVideoConfiguration.defaultConfigurationForQuality(LFLiveVideoQuality.Medium1)
        let session = LFLiveSession(audioConfiguration: audioConf, videoConfiguration: videoConf)
        session?.captureDevicePosition = .Front
        session?.delegate = self
        session?.preView = self.topView
        return session!
    }()
    
    private lazy var endView: MyLiveEndView = {
        let ev = MyLiveEndView.myLiveEndView()
        ev.frame = self.view.bounds
        ev.backToHomeBlock = { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        return ev
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestAccessForVideo()
        requestAccessForAudio()
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
      
        super.viewWillAppear(animated)
        liveTitleTextField.becomeFirstResponder() 
    }
    
    private func beginSession() {
        // 开启
        liveSession.running = true
        // 设置摄像头方向
        liveSession.captureDevicePosition = .Front

    }
    
    private func requestAccessForVideo() {
        let videoStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        
        switch videoStatus {
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (_) in
                self.beginSession()
            })
        case .Authorized:
            beginSession()
        default:
            HeadHud.showHUD("摄像设备无法访问")
            break
        }
    }
    
    private func requestAccessForAudio() {
        let audioStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
        switch audioStatus {
        case .NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler:nil)
        case .Authorized:
            break
        default:
            HeadHud.showHUD("话筒设备无法访问")
            break
        }
    }


    // 结束直播
    @IBAction func back(sender: UIButton) {
        let action = LMYAlertAction(title: "确定结束直播")
        action.show()
        action.confirmBlock = {
            self.liveSession.stopLive()
            self.view.addSubview(self.endView)
        }
    }

    // 开始直播
    @IBAction func beginLive(sender: UIButton) {
        liveSession.preView = self.view
        topView.removeFromSuperview()
        
        // 开始直播
        let streamInfo = LFLiveStreamInfo()
        streamInfo.url = "rtmp://192.168.1.44:1935/rtmplive/room2"
        liveSession.startLive(streamInfo)
    }

    // 返回
    @IBAction func dismiss() {
        liveTitleTextField.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 摄像头翻转
    @IBAction func reverseCamera(sender: UIButton) {
        let currentPosition = liveSession.captureDevicePosition
        liveSession.captureDevicePosition = currentPosition == .Front ? .Back : .Front
    }
    
    // 是否美颜, 默认美颜
    @IBAction func beautyFace(sender: UIButton) {
        sender.selected = !sender.selected
        liveSession.beautyFace = !liveSession.beautyFace
    }
    
    @IBAction func mirrorClicked(sender: UIButton) {
        sender.selected = !sender.selected
        liveSession.mirror = !liveSession.mirror
    }
}

// MARK: - UI
extension MyLiveViewController {
    private func setupUI() {
        profileView.layer.cornerRadius = 20
        profileView.layer.masksToBounds = true
        
        liveTitleTextField.tintColor = UIColor(red: 28 / 255.0, green: 191 / 255.0, blue: 179 / 255.0, alpha: 1.0)
        liveTitleTextField.setValue(UIColor.whiteColor(), forKeyPath: "placeholderLabel.textColor")
    }
}

// MARK: - LFLiveSessionDelegate
extension MyLiveViewController: LFLiveSessionDelegate {
    func liveSession(session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case .Ready:
            connectionLabel.text = "未连接"
        case .Pending:
            connectionLabel.text = "连接中"
        case .Start:
            connectionLabel.text = "已连接"
        case .Stop:
            connectionLabel.text = "已断开"
        case .Error:
            connectionLabel.text = "连接出错"
        }
    }
}