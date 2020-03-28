package com.example.protectappnative;


import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

import com.example.myapplication987.R;

public class ProxyActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                try {
                    Class mainActivityClass = Class.forName("com.example.protectappnative.MainActivity", true, getClassLoader());
                    Intent mainIntent = new Intent(ProxyActivity.this, mainActivityClass);
                    startActivity(mainIntent);
                    finish();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        }, 1000);
    }
}
