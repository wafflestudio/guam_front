package com.wafflestudio.guam

import android.os.Bundle
import android.view.animation.Animation
import android.view.animation.AnimationUtils
import android.widget.ImageView
import io.flutter.embedding.android.FlutterActivity
import androidx.appcompat.app.AppCompatActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val iv = findViewById<ImageView>(R.id.iv)
        val anim = AnimationUtils.loadAnimation(this, R.anim.anim_slide_fish).also {
            it.setAnimationListener(object : Animation.AnimationListener {
                override fun onAnimationStart(animation: Animation?) {}

                override fun onAnimationRepeat(animation: Animation?) {}

                override fun onAnimationEnd(animation: Animation?) {
                    //context 전환
                    startActivity(FlutterActivity.createDefaultIntent(this@MainActivity))
                }
            })
        }

        iv.startAnimation(anim)
    }
}
