package keyfun.app.androidapp

import android.annotation.SuppressLint
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.webkit.WebResourceError
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    companion object {
        const val TAG = "MainActivity"
        lateinit var appContext: Context

        fun showToast(message: String) {
            Toast.makeText(appContext, message, Toast.LENGTH_LONG).show()
        }
    }

    // same as localhost
    private val url = "http://10.0.2.2:9000"
    private val host = "10.0.2.2"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        appContext = applicationContext

        initWebView()
        webView.loadUrl(url)
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun initWebView() {
        webView.settings.javaScriptEnabled = true
        webView.addJavascriptInterface(DemoWebInterface(), DemoWebInterface.TAG)

        webView.webViewClient = object : WebViewClient() {
            @RequiresApi(Build.VERSION_CODES.M)
            override fun onReceivedError(
                view: WebView,
                request: WebResourceRequest,
                error: WebResourceError
            ) {
                super.onReceivedError(view, request, error)
                Log.d(TAG, error.description.toString())
            }

            override fun shouldOverrideUrlLoading(
                view: WebView?,
                request: WebResourceRequest?
            ): Boolean {
                val url = request?.url.toString()
                return (Uri.parse(url).host == host)
            }
        }
    }
}
