
import { NativeModules } from 'react-native'

const { RNTDimension } = NativeModules

export const STATUS_BAR_HEIGHT = RNTDimension.STATUS_BAR_HEIGHT
export const NAVIGATION_BAR_HEIGHT = RNTDimension.NAVIGATION_BAR_HEIGHT
export const SCREEN_WIDTH = RNTDimension.SCREEN_WIDTH
export const SCREEN_HEIGHT = RNTDimension.SCREEN_HEIGHT
export const SAFE_AREA_TOP = RNTDimension.SAFE_AREA_TOP
export const SAFE_AREA_BOTTOM = RNTDimension.SAFE_AREA_BOTTOM
export const SAFE_AREA_LEFT = RNTDimension.SAFE_AREA_LEFT
export const SAFE_AREA_RIGHT = RNTDimension.SAFE_AREA_RIGHT

export default {

  getStatusBarHeight() {
    return RNTDimension.getStatusBarHeight()
  },

  getNavigationBarHeight() {
    return RNTDimension.getNavigationBarHeight()
  },

  getScreenSize() {
    return RNTDimension.getScreenSize()
  },

  getSafeArea() {
    return RNTDimension.getSafeArea()
  },

}
