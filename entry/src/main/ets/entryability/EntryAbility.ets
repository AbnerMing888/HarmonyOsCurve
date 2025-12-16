import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { WindowUtils } from '../pages/WindowUtils';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');


    let windowClass: window.Window = windowStage.getMainWindowSync(); // 获取应用主窗口

    let isLayoutFullScreen = true;
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      console.info('Succeeded in setting the window layout to full-screen mode.');
    }).catch((err: BusinessError<void>) => {
      console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    });

    let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR // 以导航条避让为例
    let avoidArea = windowClass.getWindowAvoidArea(type)
    let bottomRectHeight = avoidArea.bottomRect.height // 获取到导航条区域的高度
    WindowUtils.windowBottomNavHeight = bottomRectHeight

    let typeSystem = window.AvoidAreaType.TYPE_SYSTEM // 以状态栏避让为例
    let avoidAreaSystem = windowClass.getWindowAvoidArea(typeSystem)
    let topRectHeight = avoidAreaSystem.topRect.height // 获取状态栏区域高度
    WindowUtils.windowTopNavHeight = topRectHeight

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}