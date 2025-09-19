package com.example.helloandroidtest;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private TextView textView;
    private Button changeTextButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // ডিজাইন ফাইলের এলিমেন্টগুলোকে কোডের সাথে যুক্ত করা
        textView = findViewById(R.id.textView);
        changeTextButton = findViewById(R.id.changeTextButton);

        // বাটনে ক্লিক করলে কী হবে তা নির্ধারণ করা
        changeTextButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                textView.setText("Wow, it works!");
            }
        });
    }
}
