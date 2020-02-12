// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

@interface MediaControlsHeaderView : UIView 
@property (nonatomic,retain) UIButton *routingButton; 
@property (assign,nonatomic) BOOL shouldUseOverrideSize;

- (void)layoutSubviews;
- (void)clearOverrideSize;
- (void)setOverrideSize:(CGSize)arg1 ;
- (UIButton *)routingButton;
- (void)setRoutingButton:(UIButton *)arg1 ;
- (BOOL)shouldUseOverrideSize;
@end

@interface MRPlatterViewController : UIViewController
@property (nonatomic,retain) UIView *routingCornerView; 
@property (nonatomic,retain) UIView *parentContainerView; /* This is song progress bar, previous, play / pause, next */
@property (nonatomic,retain) MediaControlsHeaderView* nowPlayingHeaderView; /* This is the top bar, so, artwork, title, artist, album and casting */

-(void)viewWillAppear:(BOOL)arg1 ;
-(void)viewWillDisappear:(BOOL)arg1 ;
-(void)viewDidLoad;

@end

%hook MediaControlsHeaderView
CGRect originalRouteRect;
UIView *padlockView;

- (UIButton *)routingButton {
	UIButton *origButton = %orig;
	if (CGRectIsEmpty(originalRouteRect)) {
		originalRouteRect = origButton.frame;
	}
	CGRect newRouteFrame = CGRectMake(self.frame.size.width - originalRouteRect.size.width - 15, self.frame.size.height - originalRouteRect.size.height, originalRouteRect.size.width, originalRouteRect.size.height);
	origButton.frame = newRouteFrame;
	return origButton;
}

- (void)setRoutingButton:(UIButton *)arg1 {
	%orig(arg1);
	if (CGRectIsEmpty(originalRouteRect)) {
		originalRouteRect = arg1.frame;
	}
	CGRect newRouteFrame = CGRectMake(self.frame.size.width - originalRouteRect.size.width - 15, self.frame.size.height - originalRouteRect.size.height, originalRouteRect.size.width, originalRouteRect.size.height);
	arg1.frame = newRouteFrame;
}

%end


%hook MRPlatterViewController
UIView *padlockView;

-(void)viewWillAppear:(BOOL)arg1 {
	%orig(arg1);
	//The routing button is:
	UIButton *routeButton = self.nowPlayingHeaderView.routingButton;
	CGRect originalRouteRect = routeButton.frame;
	CGRect padlockFrame =  CGRectMake(originalRouteRect.origin.x, originalRouteRect.origin.y-originalRouteRect.size.height, originalRouteRect.size.width, originalRouteRect.size.height);
	
	if (!padlockView) {
		padlockView = [[UIView alloc] initWithFrame:CGRectZero];
		[self.nowPlayingHeaderView addSubview: padlockView];
	}
	[padlockView setFrame: padlockFrame];
	[padlockView setBackgroundColor:[UIColor redColor]];
}

%end

