package com.moyou.pet_community;

import android.os.Bundle;

import androidx.annotation.Nullable;

import cn.jpush.android.api.JPushInterface;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
//        setTheme(R.style.Theme_AppCompat);
        super.onCreate(savedInstanceState);
        JPushInterface.setDebugMode(true);
        JPushInterface.init(this);
    }
}
