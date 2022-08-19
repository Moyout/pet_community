package com.moyou.pet_community;

import android.os.Bundle;

import androidx.annotation.Nullable;

import cn.jpush.android.api.JPushInterface;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        JPushInterface.setDebugMode(true);
        JPushInterface.init(this);
    }
}
