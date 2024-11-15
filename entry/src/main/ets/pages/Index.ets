import { ActionBar } from '@abner/bar'
import router from '@ohos.router'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/11/13
 * INTRODUCE:首页
 * */


@Entry
@Component
struct Index {
  private mGridData: string[] = ["任意组件刷新", "List组件刷新", "Grid组件刷新",
    "WaterFlow组件刷新", "自定义刷新头尾", "自动下拉刷新",
    "无阻尼效果", "加载数据不回弹", "显示暂无数据", "固定暂无数据", "刷新不禁止拖动", "三个点刷新头",
    "懒加载封装使用"]
  private mRouterData: string[] = [
    "pages/RefreshUpAndDownPage", "pages/ListUpAndDownPage", "pages/GridUpAndDownPage",
    "pages/WaterFlowUpAndDownPage", "pages/RefreshHeaderAndFooterPage",
    "pages/AutoRefreshPage", "pages/NoScrollSpringPage", "pages/LoadDataSpringBackPage",
    "pages/FooterNothingPage", "pages/FixedFooterPage", "pages/RefreshScrollPage",
    "pages/RefreshPointPage", "pages/LazyDataOperationPage"
  ]

  build() {
    Column() {
      ActionBar({
        title: "轻盈刷新库功能"
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