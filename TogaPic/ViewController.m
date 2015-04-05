//
//  ViewController.m
//  TogaPic
//
//  Created by Shuya Honda on 2015/04/05.
//  Copyright (c) 2015年 Shuya Honda. All rights reserved.
//

#import "ViewController.h"
#import "PeerListViewController.h"
#import "SessionHelper.h"

static NSString * const SegueIdentifierPushPeerListView = @"PushPeerListViewSegue";
typedef enum pictureType {
    Heart,
    Star
}pictureType;

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCBrowserViewControllerDelegate, SessionHelperDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property pictureType selectedPictureType;
@property (nonatomic) SessionHelper *sessionHelper;
@property (nonatomic) MCPeerID *selectedPeerID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.sessionHelper = [[SessionHelper alloc] initWithDisplayName:@"test"];
    self.sessionHelper.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createSessionButtonDidTouch:(id)sender {
    MCBrowserViewController *viewController = [[MCBrowserViewController alloc] initWithServiceType:self.sessionHelper.serviceType
                                                                                           session:self.sessionHelper.session];
    viewController.delegate = self;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)pushDeviceConnect:(id)sender {
}



#pragma mark - IBAction

- (IBAction)pushRedButton:(id)sender {
}

- (IBAction)pushBlueButton:(id)sender {
}

- (IBAction)pushBlackButton:(id)sender {
}

- (IBAction)pushStarButton:(id)sender {
    self.selectedPictureType = Star;
}

- (IBAction)pushHeartButton:(id)sender {
    self.selectedPictureType = Heart;
}

- (IBAction)pushImageSelect:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    [self sendImage];
}

#pragma mark - ImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Touch Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.imageView];
    CGPoint viewLocation = [touch locationInView:self.view];
    NSLog(@"Touch ImageViewLocationx :%f y:%f", location.x, location.y);
    
    if (!CGRectContainsPoint(self.imageView.frame, viewLocation)) {
        return;
    }
    
    if (self.selectedPictureType == Heart) {
        UIImage *image = [UIImage imageNamed:@"heart"];
        CGRect rect = CGRectMake(location.x, location.y, 30, 30);
        UIImageView *heartImage = [[UIImageView alloc] initWithImage:image];
        heartImage.frame = rect;
        [self.imageView addSubview:heartImage];
        
        [self sendText:@"heart" rect:rect];
        
    } else if (self.selectedPictureType == Star) {
        UIImage *image = [UIImage imageNamed:@"star"];
        CGRect rect = CGRectMake(location.x, location.y, 30, 30);
        UIImageView *heartImage = [[UIImageView alloc] initWithImage:image];
        heartImage.frame = rect;
        [self.imageView addSubview:heartImage];
        
        [self sendText:@"star" rect:rect];
    } else {
        NSLog(@"絵のタイプが選択されていません");
    }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

# pragma mark - MCBrowseViewController
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController
      shouldPresentNearbyPeer:(MCPeerID *)peerID
            withDiscoveryInfo:(NSDictionary *)info
{
    return YES;
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Sesstion Helper Delegate

- (void)sessionHelperDidChangeConnectedPeers:(SessionHelper *)sessionHelper {
    
}

- (void)sessionHelperDidRecieveImage:(UIImage *)image peer:(MCPeerID *)peerID {
    NSLog(@"画像を受信しました");
    self.imageView.image = image;
}

- (void)sessionHelperDidRecieveText:(NSString *)text peer:(MCPeerID *)peerID {
    NSLog(@"テキストを受信しました -> %@",text);
    
    NSArray *separatedText = [text componentsSeparatedByString:@","];
    NSLog(@"%@",separatedText);
    
    if ([separatedText[0] isEqual:@"heart"]) {
        UIImage *image = [UIImage imageNamed:@"heart"];
        
        NSString *x = separatedText[1];
        NSString *y = separatedText[2];
        
                       
        CGRect rect = CGRectMake([x floatValue] , [y floatValue], 30, 30);
        UIImageView *heartImage = [[UIImageView alloc] initWithImage:image];
        heartImage.frame = rect;
        [self.imageView addSubview:heartImage];
    } else {
        UIImage *image = [UIImage imageNamed:@"star"];
        
        NSString *x = separatedText[1];
        NSString *y = separatedText[2];
        
        
        CGRect rect = CGRectMake([x floatValue] , [y floatValue], 30, 30);

        UIImageView *starImage = [[UIImageView alloc] initWithImage:image];
        starImage.frame = rect;
        [self.imageView addSubview:starImage];
        
        [self sendText:@"star" rect:rect];

    }
}


#pragma mark - Private

- (void)sendImage {
    NSLog(@"%ld",self.sessionHelper.connectedPeersCount);
    [self.sessionHelper sendImage:self.imageView.image peerID:[self.sessionHelper connectedPeerIDAtIndex:0]];
}

- (void)sendText:(NSString *)type rect:(CGRect)rect {
    
    // format -> heart,100,120
    // type,location.x,location.y
    
    NSString *text = [NSString stringWithFormat:@"%@,%f,%f",type,rect.origin.x,rect.origin.y];//
    [self.sessionHelper sendText:text peerID:[self.sessionHelper connectedPeerIDAtIndex:0]];
}

@end
