package com.github.musicode.dimension

import android.os.Build
import com.facebook.react.bridge.*
import android.view.Display
import android.content.Context.WINDOW_SERVICE
import android.graphics.Point
import android.graphics.Rect
import android.view.WindowManager
import java.lang.Exception
import java.util.HashMap

class RNTDimensionModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "RNTDimension"
    }

    override fun getConstants(): Map<String, Any>? {

        val constants: MutableMap<String, Any> = HashMap()

        // 记录第一次的值
        constants["STATUS_BAR_HEIGHT"] = getStatusBarHeight()
        constants["NAVIGATION_BAR_HEIGHT"] = getNavigationBarHeight()

        val screenSize = getScreenSizeMap()
        constants["SCREEN_WIDTH"] = screenSize.getInt("width")
        constants["SCREEN_HEIGHT"] = screenSize.getInt("height")

        val safeArea = getSafeAreaMap()
        constants["SAFE_AREA_TOP"] = safeArea.getInt("top")
        constants["SAFE_AREA_BOTTOM"] = safeArea.getInt("bottom")
        constants["SAFE_AREA_LEFT"] = safeArea.getInt("left")
        constants["SAFE_AREA_RIGHT"] = safeArea.getInt("right")

        return constants

    }

    private val density: Float by lazy {
        reactApplicationContext.resources.displayMetrics.density
    }

    @ReactMethod
    fun getStatusBarHeight(promise: Promise) {

        val map = Arguments.createMap()
        map.putInt("height", getStatusBarHeight())

        promise.resolve(map)

    }

    private fun getStatusBarHeight(): Int {

        val resources = reactApplicationContext.resources
        val resId = resources.getIdentifier("status_bar_height", "dimen", "android")

        return if (resId > 0) {
            (resources.getDimensionPixelSize(resId) / density).toInt()
        }
        else {
            0
        }

    }

    @ReactMethod
    fun getNavigationBarHeight(promise: Promise) {

        val map = Arguments.createMap()
        map.putInt("height", getNavigationBarHeight())

        promise.resolve(map)

    }

    private fun getNavigationBarHeight(): Int {

        val window = currentActivity?.window ?: return 0

        // getScreenSize() 方法在某些手机上返回的是内容区域的尺寸
        // 导致这里返回的是 navigation bar + status bar 的高度
        // 因此我们改变思路，获取内容区域的位置信息，这样就能求出真实的 navigation bar 的高度了

        val realScreenSize = getRealScreenSize()

        val rect = Rect()

        window.decorView.getWindowVisibleDisplayFrame(rect)

        return ((realScreenSize.y - rect.bottom) / density).toInt()

    }

    @ReactMethod
    fun getScreenSize(promise: Promise) {

        promise.resolve(getScreenSizeMap())

    }

    private fun getScreenSizeMap(): WritableMap {

        // 跟 ios 保持一致，获取的是物理屏尺寸
        val screenSize = getRealScreenSize()

        val map = Arguments.createMap()
        map.putInt("width", (screenSize.x / density).toInt())
        map.putInt("height", (screenSize.y / density).toInt())

        return map

    }

    @ReactMethod
    fun getSafeArea(promise: Promise) {

        promise.resolve(getSafeAreaMap())

    }

    private fun getSafeAreaMap(): WritableMap {

        val map = Arguments.createMap()
        map.putInt("top", getStatusBarHeight())
        map.putInt("bottom", 0)
        map.putInt("left", 0)
        map.putInt("right", 0)

        val activity = currentActivity ?: return map

        // P 之前的版本都是厂商私有实现，懒得折腾了
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            val displayCutout = activity.window.decorView.rootWindowInsets?.displayCutout
            if (displayCutout != null) {
                val metrics = reactApplicationContext.resources.displayMetrics
                map.putInt("top", (displayCutout.safeInsetTop / metrics.density).toInt())
                map.putInt("bottom", (displayCutout.safeInsetBottom / metrics.density).toInt())
                map.putInt("left", (displayCutout.safeInsetLeft / metrics.density).toInt())
                map.putInt("right", (displayCutout.safeInsetRight / metrics.density).toInt())
            }
        }

        return map

    }

    private fun getScreenSize(): Point {

        val display = (reactContext.getSystemService(WINDOW_SERVICE) as WindowManager).defaultDisplay
        val size = Point()

        display.getSize(size)

        return size

    }

    private fun getRealScreenSize(): Point {

        val display = (reactContext.getSystemService(WINDOW_SERVICE) as WindowManager).defaultDisplay
        val size = Point()

        if (Build.VERSION.SDK_INT >= 17) {
            display.getRealSize(size)
        }
        else if (Build.VERSION.SDK_INT >= 14) {
            try {
                size.x = Display::class.java.getMethod("getRawWidth").invoke(display) as Int
                size.y = Display::class.java.getMethod("getRawHeight").invoke(display) as Int
            } catch (e: Exception) {
            }
        }

        return size

    }

}