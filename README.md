## 介绍
<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="100px" /><br/>
<span style="font-size:12px;color:red;">扫码关注，千帆起航，共筑鸿蒙！</span>
</p>
curve_navigation是一个正弦曲线形式的底部导航，摒弃传统的导航模式，让底部导航变得好看又有趣。

## 支持Api版本

Api适用版本：>=12

## 效果

### 静态效果

<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/curve/curve_001.png" width="300px" />
</p>

### 动态效果

<p align="center">
<img src="https://loveharmony.oss-cn-beijing.aliyuncs.com/weight/curve/curve_002.gif" width="300px" />
</p>

## 快速使用

### 1、远程依赖

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

**建议：在使用的模块路径下进行执行命令。**

```
ohpm install @abner/curve_navigation
```

方式二：在模块的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/curve_navigation": "^1.0.0"}
```

## 代码使用


```typescript

CurveNavigation({
  navigationSize: 5, //tab数量
  navigationPaddingBottom: WindowUtils.windowBottomNavHeight,//距离底部距离
  onPageChange: (position: number) => {
    //page改变
    this.selectIndex = position
  },
  tabView: (position: number) => {
    //导航视图
    this.tabView(position)
  },
  pageView: (position: number) => {
    //页面视图
    this.pageView(position)
  }
})

```

### 完整案例

```typescript
@Entry
@Component
struct Index {
  private tempColorArray: ResourceColor[] = ["#ffcc80", "#ff9323ac", "#ff26a965", "#ff93d923", "#ff11c5de",]
  @State selectIndex: number = 0
  private tabArray: Resource[] =
    [$r('sys.symbol.house_fill'), $r('sys.symbol.square_fill_grid_2x2'), $r('sys.symbol.bell_fill'),
      $r('sys.symbol.externaldrive_fill'), $r('sys.symbol.person_2_fill')]

  @Builder
  tabView(position: number) {
    if (this.selectIndex == position) {
      Column() {
        SymbolGlyph(this.tabArray[position])
          .fontSize(20)
          .renderingStrategy(SymbolRenderingStrategy.SINGLE)
          .fontColor([Color.Black])
      }
      .backgroundColor(Color.White)
      .width(35)
      .height(35)
      .borderRadius(35)
      .justifyContent(FlexAlign.Center)
    } else {
      SymbolGlyph(this.tabArray[position])
        .fontSize(20)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Gray])
    }

  }

  @Builder
  pageView(position: number) {
    Column() {
      Text(position.toString())
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.tempColorArray[position])
  }

  build() {
    RelativeContainer() {
      CurveNavigation({
        navigationSize: 5, //tab数量
        navigationPaddingBottom: WindowUtils.windowBottomNavHeight,
        onPageChange: (position: number) => {
          this.selectIndex = position
        },
        tabView: (position: number) => {
          this.tabView(position)
        },
        pageView: (position: number) => {
          this.pageView(position)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}
```

**属性介绍**

| 属性                       | 类型                         | 概述                              |
|--------------------------|----------------------------|---------------------------------|
| navigationSize           | number                     | 导航数量，默认是5                       |
| tabView                  | @BuilderParam              | 传递的导航视图                         |
| pageView                 | @BuilderParam              | 传递的页面视图                         |
| navigationHeight         | number                     | 导航高度，默认50                       |
| disableSwipe             | boolean                    | 页面是否支持滑动                        |
| onPageChange             | (position: number) => void | 页面回调监听                          |
| navigationPaddingBottom  | number                     | 内边距距离底部，主要解决沉浸式，可以设置为底部导航距离底部距离 |

## 更多案例

可以查看相关Demo【右侧仓库地址】。

## 咨询作者

如果您在使用上有问题，解决不了，或者查看精华的鸿蒙技术文章，可扫码进行操作。

<p><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="150"></p>

## License

```
Copyright (C) AbnerMing, curve_navigation Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
