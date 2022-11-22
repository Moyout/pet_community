package com.moyou.pet_community;

import android.annotation.SuppressLint;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.installations.FirebaseInstallations;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

public class FcmNotifyService extends FirebaseMessagingService {
    @Override
    public void onCreate() {
 
        super.onCreate();
    }

    @Override
    public void onMessageReceived(@NonNull RemoteMessage message) {
        super.onMessageReceived(message);

    }

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);

        SharedPreferences.Editor editor = getSharedPreferences("fcmToken", MODE_PRIVATE).edit();
        System.err.print("----onNewToken------------------------------------》" + token);

    }
}
