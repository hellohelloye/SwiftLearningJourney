##Solutions on coding problems
###### Problem on drawing bottom line For custom UICollectionViewCell | UITableViewCell
```objc
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
     /* [self.contentView addSubview:self.bottomLine]; */
}
- (void)prepareForReuse {
    [super prepareForReuse];
   /* [self.bottomLine removeFromSuperview]; */
}
```
![photo1](https://github.com/mshanken/SwiftLearningJourney/blob/master/SwiftTesting/swiftTestingScreenShot.png?raw=true)
![photo2](https://github.com/hellohelloye/SwiftLearningJourney/blob/master/WhereToTalk/Screen%20Shot%202014-06-09%20at%204.43.44%20PM.png?raw=true)
