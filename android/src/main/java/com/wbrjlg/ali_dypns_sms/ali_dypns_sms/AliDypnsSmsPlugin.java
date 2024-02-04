package com.wbrjlg.ali_dypns_sms.ali_dypns_sms;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.nirvana.prd.sms.auth.Ret;
import com.nirvana.prd.sms.auth.SmsAuthHelper;
import com.nirvana.prd.sms.auth.SmsCallback;

import java.util.Map;
import java.util.Objects;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * AliDypnsSmsPlugin
 */
public class AliDypnsSmsPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {

    private MethodChannel channel;
    private Activity activity;
    private Gson gson;

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        activity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {
        this.onAttachedToActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ali_dypns_sms");
        channel.setMethodCallHandler(this);
        gson = new Gson();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("sendSms")) {
            Map<String, String> args = call.arguments();
            String key = "phoneNumber";
            if (args == null || !args.containsKey(key) || !args.containsKey("sceneCode")) {
                result.success(gson.toJson(new com.wbrjlg.ali_dypns_sms.ali_dypns_sms.Result("100403", "参数错误，请检查后重试")));
                return;
            }

            if (Objects.requireNonNull(args.get(key)).isEmpty() || Objects.requireNonNull(args.get("sceneCode")).isEmpty()) {
                result.success(gson.toJson(new com.wbrjlg.ali_dypns_sms.ali_dypns_sms.Result("100403", "参数错误，请检查后重试")));
                return;
            }

            sendSms(args.get(key), args.get("sceneCode"), result);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    private void sendSms(String phoneNumber, String sceneCode, Result result) {
        SmsAuthHelper smsAuthHelper = new SmsAuthHelper(activity, sceneCode);

        smsAuthHelper.sendVerifyCode(86, phoneNumber, ret -> {
            result.success(gson.toJson(new com.wbrjlg.ali_dypns_sms.ali_dypns_sms.Result(ret.code, ret.msg)));
        }, 3000);
    }

}
