
import { NativeModules } from 'react-native'

const { RNTDimension } = NativeModules

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
