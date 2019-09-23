//
//  DDPopupGameSet.m
//  DDZCJ
//
//  Created by jjj on 2019/9/17.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDPopupGameSet.h"
#import "DDPopupView.h"
#import "DDZBackgroundMusic.h"


@interface DDPopupGameSet ()

@property (nonatomic, strong) UIView *pView;

@property (nonatomic, strong) UIView *xieView;

@property (nonatomic, copy)DDPopupGameSetBlock block;

@end

@implementation DDPopupGameSet

+(DDPopupGameSet *)initClient
{
    static DDPopupGameSet *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[DDPopupGameSet alloc] init];
        [client initCustom];
        
    });
    
    return client;
}

-(void) initCustom
{
    [LYWindow addSubview:self.pView];
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.pView.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self.pView addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(496)/2:Auto_Width(466)/2)];
    imgVBg.center = LYWindow.center;
    [imgVBg setImage:DDImageName(@"game_set_bg")];
    [self.pView addSubview:imgVBg];

    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pView addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self.pView)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"home_set_title")];
    [self.pView addSubview:titleImgV];
    
    UIImageView *bgMusicImgV = [[UIImageView alloc] initWithFrame:CGRectMake(DDMinX(imgVBg)+Auto_Width(60)/2,DDMaxY(titleImgV)+Auto_Height(70)/2, Auto_Width(135)/2, Auto_Width(38)/2)];
    [bgMusicImgV setImage:DDImageName(@"home_set_bgmusic")];
    [self.pView addSubview:bgMusicImgV];
    
    UIButton * bgMusicSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(60)/2-Auto_Width(159)/2, DDMaxY(titleImgV)+Auto_Height(60)/2, Auto_Width(159)/2, Auto_Width(60)/2)];
    [bgMusicSetBtn setBackgroundImage:DDImageName(@"home_set_off") forState:0];
    [bgMusicSetBtn setBackgroundImage:DDImageName(@"home_set_on") forState:UIControlStateSelected];
    [bgMusicSetBtn addTarget:self action:@selector(bgSetClick:) forControlEvents:UIControlEventTouchUpInside];
    bgMusicSetBtn.selected = YES;
    NSString *isOn = DDGET_CACHE(DDZ_SET_BgMusic);
    if (isOn) {
        if ([isOn isEqualToString:@"GBBJYY"]) {
            bgMusicSetBtn.selected = NO;
        }else{
            bgMusicSetBtn.selected = YES;
        }
    }
    [bgMusicSetBtn setAdjustsImageWhenHighlighted:NO];
    [self.pView addSubview:bgMusicSetBtn];

    UIImageView *gameMusicImgV = [[UIImageView alloc] initWithFrame:CGRectMake(DDMinX(imgVBg)+Auto_Width(60)/2,DDMaxY(bgMusicImgV)+Auto_Height(52)/2, Auto_Width(135)/2, Auto_Width(38)/2)];
    [gameMusicImgV setImage:DDImageName(@"home_set_gamemusic")];
    [self.pView addSubview:gameMusicImgV];

    UIButton * gameMusicSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(60)/2-Auto_Width(159)/2, DDMaxY(bgMusicSetBtn)+Auto_Height(30)/2, Auto_Width(159)/2, Auto_Width(60)/2)];
    [gameMusicSetBtn setBackgroundImage:DDImageName(@"home_set_off") forState:0];
    [gameMusicSetBtn setBackgroundImage:DDImageName(@"home_set_on") forState:UIControlStateSelected];
    [gameMusicSetBtn addTarget:self action:@selector(gameSetClick:) forControlEvents:UIControlEventTouchUpInside];
    gameMusicSetBtn.selected = YES;
    NSString *isOnG = DDGET_CACHE(DDZ_SET_GameMusic);
    if (isOnG) {
        if ([isOnG isEqualToString:@"GBYXYX"]) {
            gameMusicSetBtn.selected = NO;
        }else{
            gameMusicSetBtn.selected = YES;
        }
    }
    [gameMusicSetBtn setAdjustsImageWhenHighlighted:NO];
    [self.pView addSubview:gameMusicSetBtn];
    
    UIButton *xieyiBtn = [[UIButton alloc] initWithFrame:CGRectMake((DDWidth(self.pView)-Auto_Width(225)/2)/2, DDMaxY(imgVBg) - Auto_Height(46)/2 - Auto_Width(25)/2, Auto_Width(225)/2, Auto_Width(25)/2)];
    [xieyiBtn setBackgroundImage:DDImageName(@"xieyi") forState:0];
    [xieyiBtn addTarget:self action:@selector(xieyiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pView addSubview:xieyiBtn];
    
    self.xieView = [[UIView alloc] initWithFrame:LYWindow.bounds];
    //    self.xieView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [LYWindow insertSubview:self.xieView aboveSubview:self.pView];
    
    [self initXie];
}

-(void)initXie
{
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(924)/2:Auto_Width(924)/2)];
    imgVBg.center = self.xieView.center;
    [imgVBg setImage:DDImageName(@"xieyi_title_bg")];
    [self.xieView addSubview:imgVBg];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeXieClick) forControlEvents:UIControlEventTouchUpInside];
    [self.xieView addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(LYWindow)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"xieyi_title")];
    [self.xieView addSubview:titleImgV];
    
    CGFloat he_h = DDHeight(imgVBg) - DDHeight(titleImgV) - Auto_Height(20)/2 - Auto_Height(38)/2 - Auto_Height(54)/2;
    
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(DDMinX(imgVBg)+Auto_Width(40)/2, DDMaxY(titleImgV)+Auto_Height(38)/2, DDWidth(imgVBg)-Auto_Width(40), he_h)];
    textV.text = @"秀才闖關隱私政策\n引言\n秀才闖關視用戶信息安全與隱私保護爲自己的“生命線”。我們秉承“一切以用戶價值爲依據”的理念，致力於提升信息處理透明度，增強您對信息管理的便捷性，保障您的信息及通信安全。\n秀才闖關嚴格遵守法律法規，遵循以下隱私保護原則，爲您提供更加安全、可靠的服務：\n• 1、 安全可靠：我們竭盡全力通過合理有效的信息安全技術及管理流程，防止您的信息泄露、損毀、丟失\n• 2、自主選擇：我們爲您提供便利的信息管理選項，以便您做出合適的選擇，管理您的個人信息。\n• 3、 保護通信祕密：我們嚴格遵照法律法規，保護您的通信祕密，爲您提供安全的通信服務。\n• 4、 合理必要：爲了向您和其他用戶提供更好的服務，我們僅收集必要的信息。\n• 5、 清晰透明：我們努力使用簡明易懂的表述，向您介紹隱私政策，以便您清晰地瞭解我們的信息處理方式。\n• 6、 將隱私保護融入產品設計：我們在產品或服務開發的各個環節，綜合法律、產品、設計等多方因素，融入隱私保護的理念。\n本《隱私政策》主要向您說明：\n• 我們收集哪些信息；\n• 我們收集信息的用途；\n• 您所享有的權利。\n希望您仔細閱讀《隱私政策》（以下簡稱“本政策”），詳細瞭解我們對信息的收集、使用方式，以便您更好地瞭解我們的服務並作出適當的選擇。 若您使用秀才闖關服務，即表示您認同我們在本政策中所述內容。除另有約定外，本政策所用術語與《秀才闖關服務協議》中的術語具有相同的涵義。 如您有問題，請聯繫我們。\n一、我們收集的信息\n我們根據合法、正當、必要的原則，僅收集實現產品功能所必要的信息。\n• 1.1 您在使用我們服務時主動提供的信息\n• 1.1.1 您在註冊帳戶時填寫的信息。\n• 1.1.2 您在使用服務時上傳的信息。 例如，您在遊戲時，上傳的頭像、分享的照片。\n • 1.1.3 您通過我們的客服或參加我們舉辦的活動時所提交的信息。 例如，您參與我們線上活動時填寫的調查問卷中可能包含您的姓名、電話、家庭地址等信息。 我們的部分服務可能需要您提供特定的個人敏感信息來實現特定功能。若您選擇不提供該類信息，則可能無法正常使用服務中的特定功能，但不影響您使用服務中的其他功能。若您主動提供您的個人敏感信息，即表示您同意我們按本政策所述目的和方式來處理您的個人敏感信息。\n• 1.2 我們在您使用服務時獲取的信息\no 1.2.1 日誌信息。當您使用我們的服務時，我們可能會自動收集相關信息並存儲爲服務日誌信息。\n(1) 設備信息。例如，設備型號、操作系統版本、唯一設備標識符、電池、信號強度等信息。\n(2) 軟件信息。例如，軟件的版本號、瀏覽器類型。爲確保操作環境的安全或提供服務所需，我們會收集有關您使用的移動應用和其他軟件的信息。\n(3) IP地址。\n(4) 服務日誌信息。例如，您在使用我們服務時搜索、查看的信息、服務故障信息、引薦網址等信息。\n(5) 通訊日誌信息。例如，您在使用我們服務時曾經通訊的賬戶、通訊時間和時長。\no 1.2.2 位置信息。當您使用與位置有關的服務時，我們可能會記錄您設備所在的位置信息，以便爲您提供相關服務。\n(1) 在您使用服務時，我們可能會通過IP地址、GPS、WiFi或基站等途徑獲取您的地理位置信息；\n(2) 您或其他用戶在使用服務時提供的信息中可能包含您所在地理位置信息，例如您提供的帳號信息中可能包含的您所在地區信息，您或其他人共享的照片包含的地理標記信息；\n• 1.2.3 其他相關信息。爲了幫助您更好地使用我們的產品或服務，我們會收集相關信息。例如，我們收集的好友列表、羣列表信息、聲紋特徵值信息。爲確保您使用我們服務時能與您認識的人進行聯繫，如您選擇開啓導入通訊錄功能，我們可能對您聯繫人的姓名和電話號碼進行加密，並僅收集加密後的信息。\n• 1.3\n其他用戶分享的信息中含有您的信息\n例如，其他用戶發佈的照片或分享的視頻中可能包含您的信息。\n• 1.4\n從第三方合作伙伴獲取的信息\n我們可能會獲得您在使用第三方合作伙伴服務時所產生或分享的信息。例如，您使用微信或QQ帳戶登錄第三方合作伙伴服務時，我們會獲得您登錄第三方合作伙伴服務的名稱、登錄時間，方便您進行授權管理。請您仔細閱讀第三方合作伙伴服務的用戶協議或隱私政策。\n二、我們如何使用收集的信息\n我們嚴格遵守法律法規的規定及與用戶的約定，將收集的信息用於以下用途。若我們超出以下用途使用您的信息，我們將再次向您進行說明，並徵得您的同意。\n • 2.1\n向您提供服務。\n• 2.2\n滿足您的個性化需求。例如，語言設定、位置設定、個性化的幫助服務。\n• 2.3\n產品開發和服務優化。例如，當我們的系統發生故障時，我們會記錄和分析系統故障時產生的信息，優化我們的服務。\n• 2.4\n安全保障。例如，我們會將您的信息用於身份驗證、安全防範、反詐騙監測、存檔備份、客戶的安全服務等用途。例如，您下載或安裝的安全軟件會對惡意程序或病毒進行檢測，或爲您識別詐騙信息。\n• 2.5\n向您推薦您可能感興趣的廣告、資訊等。\n• 2.6\n評估、改善我們的廣告投放和其他促銷及推廣活動的效果。\n• 2.7\n管理軟件。例如，進行軟件認證、軟件升級等。\n• 2.8\n邀請您參與有關我們服務的調查。\n爲了讓您有更好的體驗、改善我們的服務或經您同意的其他用途，在符合相關法律法規的前提下，我們可能將通過某些服務所收集的信息用於我們的其他服務。例如，將您在使用我們某項服務時的信息，用於另一項服務中向您展示個性化的內容或廣告、用於用戶研究分析與統計等服務。\n爲了確保服務的安全，幫助我們更好地瞭解我們應用程序的運行情況，我們可能記錄相關信息，例如，您使用應用程序的頻率、故障信息、總體使用情況、性能數據以及應用程序的來源。我們不會將我們存儲在分析軟件中的信息與您在應用程序中提供的個人身份信息相結合。\n三、我們如何使用Cookie及相關技術\n我們或我們的第三方合作伙伴，可能通過放置安全的Cookie及相關技術收集您的信息，目的是爲您提供更個性化的用戶體驗和服務。我們會嚴格要求第三方合作伙伴遵守本政策的相關規定。\n您也可以通過瀏覽器設置管理Cookie。但請注意，如果停用Cookie，您可能無法享受最佳的服務體驗，某些服務也可能無法正常使用。。\n四、您分享的信息\n您可以通過我們的服務與您的好友、家人及其他用戶分享您的相關信息。例如，您在微信朋友圈中公開分享的文字和照片。請注意，這其中可能包含您的個人身份信息、個人財產信息等敏感信息。請您謹慎考慮披露您的相關個人敏感信息。\n您可通過我們服務中的隱私設置來控制您分享信息的範圍，也可通過服務中的設置或我們提供的指引刪除您公開分享的信息。但請您注意，這些信息仍可能由其他用戶或不受我們控制的非關聯第三方獨立地保存。\n五、您如何管理自己的信息\n• 5.1\n您可以在使用我們服務的過程中，訪問、修改和刪除您提供的註冊信息和其他個人信息， 也可按照通知指引與我們聯繫。您訪問、修改和刪除個人信息的範圍和方式將取決於您使用的具體服務。例如，若您在使用地理位置相關服務時，希望停止分享您的地理位置信息，您可通過手機定位關閉功能、軟硬件服務商及\n• 5.2\n我們將按照本政策所述，僅爲實現我們產品或服務的功能，收集、使用您的信息。如您發現我們違反法律、行政法規的規定或者雙方的約定收集、使用您的個人信息，您可以要求我們刪除。如您發現我們收集、存儲的您的個人信息有錯誤的，您也可以要求我們更正。請通過本政策列明的聯繫方式與我們聯繫。\n• 5.3\n在您訪問、修改和刪除相關信息時，我們可能會要求您進行身份驗證，以保障帳號的安全。\n• 5.4\n請您理解，由於技術所限、法律或監管要求，我們可能無法滿足您的所有要求，我們會在合理的期限內答覆您的請求。\n六、我們分享的信息\n我們遵照法律法規的規定，對信息的分享進行嚴格的限制，例如：\n• 6.1\n經您事先同意，我們可能與第三方分享您的個人信息；\n• 6.2\n僅爲實現外部處理的目的，我們可能會與第三方合作伙伴（第三方服務供應商、承包商、代理、廣告合作伙伴、應用開發者等，例如，代表我們發出電子郵件或推送通知的通訊服務提供商、爲我們提供位置服務的地圖服務供應商）（他們可能並非位於您所在的法域）分享您的個人信息，讓他們按照我們的說明，用途：\n• 6.2.1 向您提供我們的服務；\n• 6.2.2 實現“我們如何使用收集的信息”部分所述目的；\n• 6.2.3 履行我們在《秀才闖關服務協議》或本政策中的義務和行使我們的權利；\n• 6.2.4 理解、維護和改善我們的服務。\n如我們與上述第三方分享您的信息，我們將會採用加密、匿名化處理等手段保障您的信息安全。\n• 6.3\n隨着我們業務的持續發展，當發生合併、收購、資產轉讓等交易導致向第三方分享您的個人信息時，我們將通過推送通知、公告等形式告知您相關情形，按照法律法規及不低於本政策所要求的標準繼續保護或要求新的管理者繼續保護您的個人信息。\n• 6.4\n我們會將所收集到的信息用於大數據分析。例如，我們將收集到的信息用於分析形成不包含任何個人信息的城市熱力圖或行業洞察報告。我們可能對外公開並與我們的合作伙伴分享經統計加工後不含身份識別內容的信息，用於瞭解用戶如何使用我們服務或讓公衆瞭解我們服務的總體使用趨勢。\n• 6.5\n我們可能基於以下目的披露您的個人信息：\n• 6.5.1 遵守適用的法律法規等有關規定；\n• 6.5.2 遵守法院判決、裁定或其他法律程序的規定；\n• 6.5.3 遵守相關政府機關或其他法定授權組織的要求；\n• 6.5.4 我們有理由確信需要遵守法律法規等有關規定；\n• 6.5.5 爲提供您所要求的產品和服務，而必須和第三方分享您的個人信息；";
    
    textV.backgroundColor = [UIColor clearColor];
    textV.editable = NO;
    if (IS_IPAD) {
        textV.font = [UIFont systemFontOfSize:16.];
    }
    [self.xieView addSubview:textV];
    
    self.xieView.hidden = YES;
}

-(void)xieyiClick
{
//    self.block();
    [[MusicPlayObj initClient] playBgMusic];
    
    self.xieView.hidden = NO;
    [LYWindow bringSubviewToFront:self.xieView];
    
}

-(void)closeXieClick
{
    [[MusicPlayObj initClient] playBgMusic];
    self.xieView.hidden = YES;
}


-(void)showGameSetViewBlock:(DDPopupGameSetBlock)block
{
    self.block = block;
    
    if (self.pView.hidden) {
        self.pView.hidden = NO;
        [LYWindow bringSubviewToFront:self.pView];
    }
}


-(void)gameSetClick:(UIButton *)btn
{
    [[MusicPlayObj initClient] playBgMusic];
    
    btn.selected = !btn.selected;

    NSString *str = @"";
    if (btn.selected) {
        str = @"KQYXYX";
    }else{
        str = @"GBYXYX";
    }
    
    DDSET_CACHE(str, DDZ_SET_GameMusic);
}

-(void)bgSetClick:(UIButton *)btn
{
    [[MusicPlayObj initClient] playBgMusic];
    
    btn.selected = !btn.selected;

    NSString *str = @"";
    if (btn.selected) {
        str = @"KQBJYY";
        if ([AppDelegate shareDelegate].isInGame) {
            [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicStop];
            [[DDZBackgroundMusic shareBackgroundMusic] gameBackgroundMusicPlay];
        }else{
            [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicPlay];
            [[DDZBackgroundMusic shareBackgroundMusic] gameBackgroundMusicStop];
        }
    }else{
        str = @"GBBJYY";
        [[DDZBackgroundMusic shareBackgroundMusic] gameBackgroundMusicStop];
        [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicStop];
    }

    DDSET_CACHE(str, DDZ_SET_BgMusic);
}


-(void)closeClick
{
    [[MusicPlayObj initClient] playBgMusic];
    
    self.pView.hidden = YES;
}

-(UIView *)pView
{
    if (!_pView) {
        _pView = [[UIView alloc] initWithFrame:LYWindow.bounds];
    }
    return _pView;
}


@end
