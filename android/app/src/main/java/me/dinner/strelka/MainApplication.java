package me.dinner.strelka;

import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

public class MainApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    MapKitFactory.setApiKey("5f8e2953-be76-44ff-bce1-340c301796f9");
  }
}
