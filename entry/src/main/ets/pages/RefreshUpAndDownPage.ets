import { ActionBar } from '@abner/bar';
import router from '@ohos.router';
import { LitheRefresh, RefreshController } from '@abner/lithe-refresh';

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:任意组件下拉上拉
 * */
@Entry
@Component
struct RefreshUpAndDownPage {
  controller: RefreshController = new RefreshController()

  @Builder
  itemLayout() {
    Column() {
      Text("我是任意组件")
    }.width("100%")
    .height("100%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      ActionBar({
        title: "任意组件刷新",
        barBackgroundColor: Color.Pink,
        leftText: "返回",
        onLeftClick: () => {
          router.back()
        },
      })

      LitheRefresh({
        itemLayout: this.itemLayout,
        controller: this.controller,
        onRefresh: () => {
          //下拉刷新
          setTimeout(() => {
            //模拟耗时
            this.controller.finishRefresh()
          }, 2000)
        },
        onLoadMore: () => {
          //加载更多
          setTimeout(() => {
            //模拟耗时
            this.controller.finishLoadMore()
          }, 2000)
        }
      })

    }
    .height('100%')
    .width('100%')
  }
}