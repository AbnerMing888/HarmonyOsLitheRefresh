import { ActionBar } from '@abner/bar'
import router from '@ohos.router'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/10/25
 * INTRODUCE:新组件（RefreshView）
 * */


@Entry
@ComponentV2
struct RefreshIndex {
  private mGridData: string[] = ["任意组件刷新", "List组件刷新", "Grid组件刷新",
    "WaterFlow组件刷新", "自定义刷新头尾", "自动下拉刷新",
    "无阻尼效果", "最大阻尼", "加载数据不回弹", "显示暂无数据", "固定暂无数据", "刷新不禁止拖动",
    "懒加载封装使用", "沉浸式", "自适应高度", "多视图", "自动加载数据"]
  private mRouterData: string[] = [
    "pages/refresh/NewRefreshUpAndDownPage", "pages/refresh/NewListUpAndDownPage", "pages/refresh/NewGridUpAndDownPage",
    "pages/refresh/NewWaterFlowUpAndDownPage", "pages/refresh/NewRefreshHeaderAndFooterPage",
    "pages/refresh/NewAutoRefreshPage", "pages/refresh/NewNoScrollSpringPage", "pages/refresh/NewMaxScrollSpringPage",
    "pages/refresh/NewLoadDataSpringBackPage",
    "pages/refresh/NewFooterNothingPage", "pages/refresh/NewFixedFooterPage", "pages/refresh/NewRefreshScrollPage",
    "pages/refresh/NewLazyDataOperationPage", "pages/refresh/NewRefreshImmersivePage"
    , "pages/refresh/NewAdaptiveHeightPage", "pages/refresh/NewMultiViewPage", "pages/refresh/NewAutoListUpAndDownPage"
  ]

  build() {
    Column() {
      ActionBar({
        title: "系统Refresh"
      })
      Grid() {
        ForEach(this.mGridData, (item: string, index: number) => {
          GridItem() {
            Text(item)
              .width("100%")
              .height(40)
              .textAlign(TextAlign.Center)
              .fontColor(Color.Red)
              .fontWeight(FontWeight.Bold)
              .border({ width: 1, color: Color.Red, radius: 5 })
          }.onClick(() => {
            router.pushUrl({ url: this.mRouterData[index] })
          })
        })
      }.columnsTemplate("1fr 1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .padding({ left: 20, right: 20 })
    }
  }
}