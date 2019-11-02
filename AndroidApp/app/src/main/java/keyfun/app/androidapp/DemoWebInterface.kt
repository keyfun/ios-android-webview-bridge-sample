package keyfun.app.androidapp

import android.util.Log
import android.webkit.JavascriptInterface

class DemoWebInterface {
    companion object {
        const val TAG = "DemoWebInterface"
    }

    @JavascriptInterface
    fun postMessage(json: String) {
        Log.d(TAG, "postMessage = $json")
        MainActivity.showToast(json)
    }
}