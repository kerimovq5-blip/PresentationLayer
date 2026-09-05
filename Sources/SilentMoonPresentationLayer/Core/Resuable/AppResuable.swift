//
//  AppColor.swift
//  SilentMoon
//
//  Created by Kerimov Qehreman on 25.06.26.
//

//



import UIKit

enum ImagePosition {
    case leading
    case trailing
}

enum AssetColors : String{
    
    case background = "Background"
    case backgroundSecondary = "BackgroundSecondary"
    case textPrimary = "TextPrimary"
    case textSecondary  = "TextSecondary"
    case accent = "Accent"
    case buttonTitle = "ButtonTitle"
    case lightGray = "Lightgray"
    case errorColor = "ErrorColor"
    case wrongColor = "WrongColor"
    case colorIndigo = "colorIndigo"
    case datepicker = "datepicker"
    case dailyColor = "dailycolor"
    case sectionColor = "SectionColor"
    case ellipsesColor = "ellipsesColor"
    case sleepModeColor = "SleepModeColor"
    case darksleepmusic = "darksleepmusic"
    case iceBlueColor = "IceBlueColor"
   
    
    var color : UIColor {
        return UIColor(named: self.rawValue) ?? .clear
        
    }
    
}

extension UIColor  {
    func assetColor( _ colorName : AssetColors) -> UIColor {
        return colorName.color
    }
    
}


extension UIColor {
    static var background: UIColor { AssetColors.background.color }
    static var backgroundSecondary: UIColor { AssetColors.backgroundSecondary.color }
    static var textPrimary: UIColor { AssetColors.textPrimary.color }
    static var textSecondary: UIColor { AssetColors.textSecondary.color }
    static var accent: UIColor { AssetColors.accent.color }
    static var buttonTitle: UIColor { AssetColors.buttonTitle.color }
    static var errorColor: UIColor { AssetColors.errorColor.color }
    static var wrongColor: UIColor { AssetColors.wrongColor.color }
    static var colorIndigo: UIColor { AssetColors.colorIndigo.color }
    static var datepicker: UIColor { AssetColors.datepicker.color }
    static var dailyColor: UIColor { AssetColors.dailyColor.color }
    static var sectionColor: UIColor { AssetColors.sectionColor.color }
    static var ellipsesColor: UIColor { AssetColors.ellipsesColor.color }
    static var sleepModeColor: UIColor { AssetColors.sleepModeColor.color }
    static var darksleepmusic: UIColor { AssetColors.darksleepmusic.color }
    static var iceBlueColor: UIColor { AssetColors.iceBlueColor.color }
    
}

enum AppFonts {
    case title
    case titleBold
    case titleRegular
    case body
    case regularBody
    case litletitle
    case semiBold
    case mediumTitle
    var font: UIFont {
        switch self {
        case .title:
            return UIFont.systemFont(ofSize: 30, weight: .bold)
        case .titleBold:
            return UIFont.systemFont(ofSize: 24, weight: .bold)
        case .titleRegular:
            return UIFont.systemFont(ofSize: 28, weight: .regular)
        case .body:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .regularBody:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .litletitle:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        case .semiBold:
            return UIFont.systemFont(ofSize: 18, weight: .semibold)
        case .mediumTitle :
            return UIFont.systemFont(ofSize: 13, weight: .medium)
        }
    }
}
enum AppRadius{
        case buttonRadius
        case buttonRadiusSmall
        case buttonRadiusMedium
        case buttonRadiusLarge
        case sessionPlayButtonRadius
        var radius: CGFloat {
            
            switch self {
            case .buttonRadius:
                return 30
            case .buttonRadiusSmall:
                return 16
            case .buttonRadiusMedium:
                return 20
            case .buttonRadiusLarge , .sessionPlayButtonRadius:
                return 25
            }
        }
    }
