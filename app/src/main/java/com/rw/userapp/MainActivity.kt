package com.rw.userapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
//https://blog.csdn.net/baiyuliang2013/article/details/123015128
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val flutterEngine =  FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine);

        findViewById<Button>(R.id.btn_flutter).setOnClickListener {
          val its=  FlutterActivity.createDefaultIntent(this)
            startActivity(its)
        }
    }
}